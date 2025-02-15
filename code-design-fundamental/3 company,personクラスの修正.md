[3 company,personクラスの修正](3%20company,personクラスの修正.md)

← [2 改修をアプリでするか、SQLでするか](2%20改修をアプリでするか、SQLでするか.md) | [4 凝集度、結合度](4%20凝集度、結合度.md) →

---

## 課題3

問題点
- Personがどこで呼び出され、どのような変更が起こるかが予想できない
	- プロパティが公開されているので、変更に対する制限がかかっていない
- `starWorkingAt: Date`を変数に代入しており、この代入が参照渡しになっている
	- サンプルでもある通り、受け取った値に対して`.setFullYear()`を適用すると、オブジェクト内部の値に影響が出ている
- Companyもプロパティが公開されている

解決策
- `public` → `private`に変更する
- 参照渡しではなく、コピーした値を渡すようにする
	- bad: `return this.startWorkingAt`
	- good: `return new Date(this.startWorkingAt.getTime());`
- getter, setterは原則使わない
	- ロジックをPersonやCompanyに持たせる
	- 内部のプロパティの事情を知っているのは、そのクラスだけにする
		- カプセル化につながる