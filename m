Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884718;
	b=Ey6qv/v3yH0mPfAYkdGFlYvDwF+Zp2S3X3Y8FAXEafpcbPA+8nWVUXKSJGhZ8KKi67pC
	 r6UDhWRdGQ9UbcTiJmLttV0glv/2sCIMfJ+qTKvw4G5vBavNikjMSh+teLQPBKrRnEDr0
	 H5QMtFWKVxHb3klheR4AL6PUGvTW/ZqqsSfqaLMJ5Xx/12pdGQXKqvcRKEIXOmbSV6VC6
	 3ojLBwDAQRukVrI+hcWa8HzDnixI2otiBbIhwYMrymty7507teOKMImdvMQL2if/axHQn
	 LUCUfpSBy/WJi3vBrRISJU43870vK2+/TvFm5Hp+Z7516uFcfbpBtY+JAnHZ59PBJBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884718;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qHLq6yg5piRGn0Ou6m9tvpWC0WwQwWAlt3GVgH5CeUY=;
	b=Ybd45A2fFMRZIet3n9CtHJ2END76Ptdsd6fVT9ovan9F9s3834tbHfKTRTGf7z8CP0A2
	 OVKs6tmGfiCNQr6uYGAdtWqguwNAiywo3yIKUZzoJngP0CsIrlcj9Uz5zwNUXFoluoQtT
	 OhKgv55sZfc3FggA+49mN4+UPe06wgBzTrZwoWbLZ+P43PI33o0xqA63L0d6+r2KV5Ulr
	 y68AWaQoR36d4+lWHrj4qbm2S0YXWEatP3CbFnd9t9RObxYCttm21wRJXJPcE2+Exushn
	 dP9eWiyWVvz+23GuqqFcPt6HfCNWwsVPXCLuOcWTakfbOKsjXgfBY0icOLsTFFm8P4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTXpC0zn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276ED606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTXpC0zn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DA01F00A1E;
	Thu,  5 Nov 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884717;
	bh=qHLq6yg5piRGn0Ou6m9tvpWC0WwQwWAlt3GVgH5CeUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DTXpC0zn0asQXnDNKRIpL6LWuLCicocjphvrIaZbCYRcprrFcjIZGJF6BQhjPNc0o
	 R1NcYGcWx+4IBYSKTJamEw/3BrwdMCRshlJ9GUQFyuSScD78gX6IYE9kc7mQjyrDss
	 IRf+R7M/Q+7yoW4Dz7wTGrV/gMDO9wduqsrDRieTLnSE5JQ5cuVcc9ZQn20+d2f4Nb
	 Z+KgzZoMn/nGy6K0Z37G3D+DqM++84i4VtI5JWFSNGi4uKJTRL4pfmijMzp/6klDpx
	 uR5Guu6N+UNqD2EUtz75HnIOwaeOQGyGordQGV3xHJRMsY2G9x7w0oDluMLZm25hqA
	 n4ivl7j/GnLMA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Nov 2026 14:18:08 +0100
Subject: [PATCH 4/5] Documentation/litmus-tests: add the file reference
 count tests
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-work-file_ref-ordering-v1-4-8713f4876b7b@kernel.org>
References: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
In-Reply-To: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=18492; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7/BaLdUzM7fHBoLIcjUAZuhHwJ28qdZrvRkhRWRSUFs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9aVJQKZwbVOx0q0/43y2GI9MmmYvu+765+enZYCmTk
 DSPh88SOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi9I2R4a149xYt+2eXTiuc
 YJjNfyV/17pY9qXlLnrsoW9YI53WKzMyXPCzC5R0y5ncsNCQzXPVVqsjeYt/rKi5zTdDSezhLKZ
 KXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A struct file is SLAB_TYPESAFE_BY_RCU and __fget_files_rcu() does a
lockless lookup against that: it loads the descriptor slot, takes a
reference with file_ref_get(), reloads the slot and compares. Between
the first load and the increment the file can be closed, freed and
handed out again by open(), on the same CPU or on another one through
the slab freelist. The three patches before this one rest on three
orderings in that dance:

(1) acquire ordering on file_ref_get: The reload has to be ordered
    after the increment or the recheck can read the old slot after the
    increment hit the recycled file.

(2) reload dependency: What the caller reads from the file has to depend
    on the reload, not on the first load otherwise a thread that closes
    and reopens the same descriptor and gets the same file back lets a
    concurrent lookup read the old one's f_op.

(3) full ordering on file_ref_put(): in the synchronous free paths
    nothing else orders the cleared store before the freelist store that
    hands out the object to another CPU.

Add litmus tests so we can check that against the kernel memory model.
Each ordering gets a test of the code as it is after this series.

The generic facts these rest on are in tools/memory-model already and
aren't repeated: MP+onceassign+derefonce for the dependency that
orders a load after the release store its pointer came from, and
Z6.0+pooncerelease+poacquirerelease+fencembonceonce for why a
release-acquire chain doesn't make an earlier store visible to a third
CPU without a full barrier.

What's specific to file_ref is the counter being set up again on a
recycled object, the recheck, and the handoff through the freelist, and
that's what the tests are about.

Run them with herd7 against tools/memory-model:

    cd tools/memory-model
    scripts/checklitmus.sh ../../Documentation/litmus-tests/fs/<test>

A "Never" there holds on every architecture, since each one's atomics,
barriers and RCU have to follow the memory model.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/litmus-tests/README                  | 57 ++++++++++++++++
 .../fs/file-ref-get-acquire-recheck.litmus         | 66 +++++++++++++++++++
 .../fs/file-ref-get-relaxed-recheck.litmus         | 50 ++++++++++++++
 .../fs/file-ref-put-full-handoff.litmus            | 76 ++++++++++++++++++++++
 .../fs/file-ref-put-release-handoff.litmus         | 66 +++++++++++++++++++
 .../fs/file-ref-reload-dep-field.litmus            | 74 +++++++++++++++++++++
 .../fs/file-ref-reload-nodep-field.litmus          | 59 +++++++++++++++++
 7 files changed, 448 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 6c666f3422ea..ce3a089efdac 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -38,6 +38,63 @@ cmpxchg-fail-unordered-2.litmus
     acquire operation.
 
 
+fs (/fs directory)
+------------------
+
+A struct file is SLAB_TYPESAFE_BY_RCU.  __fget_files_rcu() loads the
+descriptor slot, takes a reference with file_ref_get(), reloads the
+slot and compares, and between the first load and the increment the
+file can be closed, freed and handed out again.  The tests encode the
+counter as an atomic_t holding references minus one (ONEREF 0, NOREF
+-1, DEAD -4), file_ref_get() as atomic_fetch_add() with the ordering
+under test, file_ref_put() as atomic_fetch_sub() followed by the
+cmpxchg to DEAD of __file_ref_put(), init_file() as a plain
+atomic_set() and fd_install() as a release store.  The slot is an int
+where only its identity matters and a pointer where a later load has
+to depend on it.  The counter is a separate variable, so the address
+dependency of the increment on the first load is not in the model;
+that only makes the model weaker than the code, a "Never" here holds
+for the code.
+
+file-ref-get-acquire-recheck.litmus
+    Demonstrates that an acquire-ordered file_ref_get() is enough for
+    the recheck of __fget_files_rcu(): the full ordering of the
+    decrement orders the cleared slot before the counter is set up
+    again and the acquire orders the reload after the increment, so a
+    lookup that increments a recycled file cannot pass the recheck with
+    the old slot.
+
+file-ref-get-relaxed-recheck.litmus
+    The same with a relaxed increment; the reload can be satisfied
+    before the increment and the lookup returns a file the descriptor
+    never named.
+
+file-ref-reload-dep-field.litmus
+    Demonstrates that reading the file's fields through the reloaded
+    pointer, as __get_file_rcu() does, orders them after the store of
+    fd_install() that the reload saw: a thread that closes and reopens
+    the same descriptor and gets the same file back cannot make a
+    concurrent lookup read the old incarnation's f_op.
+
+file-ref-reload-nodep-field.litmus
+    The same with the fields read through the pointer of the first
+    load; the field read is ordered after the increment but not after
+    the reload, and a fully ordered increment does not change that.
+
+file-ref-put-full-handoff.litmus
+    Demonstrates why file_ref_put() keeps its full ordering: when the
+    last put frees the file synchronously and another CPU takes it from
+    the slab freelist, the fully ordered decrement orders the cleared
+    slot before the free, so a lookup on a third CPU that increments
+    the recycled counter cannot pass its recheck with the old slot.
+
+file-ref-put-release-handoff.litmus
+    The same with a release-ordered decrement; it orders the cleared
+    slot before the decrement and not before the free, and the lookup
+    can keep a reference to a recycled file for a descriptor that never
+    named it.
+
+
 locking (/locking directory)
 ----------------------------
 
diff --git a/Documentation/litmus-tests/fs/file-ref-get-acquire-recheck.litmus b/Documentation/litmus-tests/fs/file-ref-get-acquire-recheck.litmus
new file mode 100644
index 000000000000..576b5ba2d2e8
--- /dev/null
+++ b/Documentation/litmus-tests/fs/file-ref-get-acquire-recheck.litmus
@@ -0,0 +1,66 @@
+C file-ref-get-acquire-recheck
+
+(*
+ * Result: Never
+ *
+ * __fget_files_rcu() loads the descriptor slot, takes a reference with
+ * file_ref_get() and reloads the slot to check that it still holds the
+ * same file.  Files are SLAB_TYPESAFE_BY_RCU, so between the first load
+ * and the increment the file can be closed, freed and handed out again
+ * by open(), and the increment then lands on the recycled file.  The
+ * recheck catches that only if the reload is ordered after the
+ * increment.
+ *
+ * P0 is the owner: close() clears the slot in file_close_fd_locked()
+ * with a plain store of NULL, fput() drops the last reference with the
+ * fully ordered decrement of file_ref_put() and the cmpxchg to DEAD of
+ * __file_ref_put(), __fput() frees the file, and open() gets the same
+ * object back: init_file() sets ONEREF with a plain store and
+ * fd_install() publishes it in another slot with a release store.  P1
+ * is the lookup with an acquire-ordered file_ref_get(), i.e.
+ * atomic_long_add_negative_acquire().
+ *
+ * The full ordering of the decrement orders the cleared slot before the
+ * counter's re-initialisation and the acquire orders the reload after
+ * the increment.  So once the increment has hit the recycled counter
+ * (1:r1=0 after the successful cmpxchg, 0:r1=-1) the reload sees the
+ * cleared slot and the lookup retries.
+ *)
+
+{
+	atomic_t cnt = ATOMIC_INIT(0);
+	slot=1;
+	slot2=0;
+	0:r1=-9;
+}
+
+P0(int *slot, int *slot2, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*slot, 0);
+	r0 = atomic_fetch_sub(1, cnt);
+	if (r0 == 0) {
+		r1 = atomic_cmpxchg_release(cnt, -1, -4);
+		if (r1 == -1) {
+			atomic_set(cnt, 0);
+			smp_store_release(slot2, 1);
+		}
+	}
+}
+
+P1(int *slot, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*slot);
+	r1 = atomic_fetch_add_acquire(1, cnt);
+	r2 = READ_ONCE(*slot);
+	rcu_read_unlock();
+}
+
+exists (0:r1=-1 /\ 1:r0=1 /\ 1:r1=0 /\ 1:r2=1)
diff --git a/Documentation/litmus-tests/fs/file-ref-get-relaxed-recheck.litmus b/Documentation/litmus-tests/fs/file-ref-get-relaxed-recheck.litmus
new file mode 100644
index 000000000000..6f095eeafdce
--- /dev/null
+++ b/Documentation/litmus-tests/fs/file-ref-get-relaxed-recheck.litmus
@@ -0,0 +1,50 @@
+C file-ref-get-relaxed-recheck
+
+(*
+ * Result: Sometimes
+ *
+ * file-ref-get-acquire-recheck.litmus with a relaxed increment.  Nothing
+ * orders the reload after the increment anymore, so the reload can be
+ * satisfied before the increment hits the recycled counter: the lookup
+ * holds a reference to the recycled file and its recheck still saw the
+ * old slot, so it returns a file the descriptor never named.  Acquire
+ * is the minimum for file_ref_get().
+ *)
+
+{
+	atomic_t cnt = ATOMIC_INIT(0);
+	slot=1;
+	slot2=0;
+	0:r1=-9;
+}
+
+P0(int *slot, int *slot2, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*slot, 0);
+	r0 = atomic_fetch_sub(1, cnt);
+	if (r0 == 0) {
+		r1 = atomic_cmpxchg_release(cnt, -1, -4);
+		if (r1 == -1) {
+			atomic_set(cnt, 0);
+			smp_store_release(slot2, 1);
+		}
+	}
+}
+
+P1(int *slot, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*slot);
+	r1 = atomic_fetch_add_relaxed(1, cnt);
+	r2 = READ_ONCE(*slot);
+	rcu_read_unlock();
+}
+
+exists (0:r1=-1 /\ 1:r0=1 /\ 1:r1=0 /\ 1:r2=1)
diff --git a/Documentation/litmus-tests/fs/file-ref-put-full-handoff.litmus b/Documentation/litmus-tests/fs/file-ref-put-full-handoff.litmus
new file mode 100644
index 000000000000..158bcbc82779
--- /dev/null
+++ b/Documentation/litmus-tests/fs/file-ref-put-full-handoff.litmus
@@ -0,0 +1,76 @@
+C file-ref-put-full-handoff
+
+(*
+ * Result: Never
+ *
+ * Why file_ref_put() keeps its full ordering.  When the last put frees
+ * the file synchronously, in __fput_sync() or on the fallback path of
+ * fput_close_sync(), the object goes to another CPU through the slab
+ * freelist, that CPU recycles it, sets ONEREF and publishes it in a
+ * slot of its own, and a lookup on a third CPU can increment the
+ * recycled counter.  Its recheck must then see the cleared slot, which
+ * needs the slot clear ordered before the free.
+ *
+ * P0 is the owner: close() clears the slot, the fully ordered decrement
+ * of file_ref_put() reaches NOREF, the cmpxchg of __file_ref_put()
+ * marks the file DEAD, __fput() frees it and the object lands on the
+ * freelist, a relaxed RMW in SLUB and a plain store here.  P2 is open()
+ * on another CPU: it takes the object from the freelist, a load that
+ * the stores of init_file() depend on by control, sets ONEREF and
+ * publishes the file with fd_install().  P1 is __fget_files_rcu() with
+ * an acquire-ordered file_ref_get().
+ *
+ * The full barrier of the decrement orders the cleared slot before the
+ * freelist store.  P2's control dependency orders its stores after the
+ * freelist load, the acquire on P1 orders the reload after the
+ * increment that read P2's ONEREF, so the reload sees the cleared slot.
+ *)
+
+{
+	atomic_t cnt = ATOMIC_INIT(0);
+	slot=1;
+	slot2=0;
+	fl=0;
+	0:r1=-9;
+}
+
+P0(int *slot, int *fl, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*slot, 0);
+	r0 = atomic_fetch_sub(1, cnt);
+	if (r0 == 0) {
+		r1 = atomic_cmpxchg_release(cnt, -1, -4);
+		if (r1 == -1) {
+			WRITE_ONCE(*fl, 1);
+		}
+	}
+}
+
+P1(int *slot, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*slot);
+	r1 = atomic_fetch_add_acquire(1, cnt);
+	r2 = READ_ONCE(*slot);
+	rcu_read_unlock();
+}
+
+P2(int *slot2, int *fl, atomic_t *cnt)
+{
+	int r0;
+
+	r0 = READ_ONCE(*fl);
+	if (r0 == 1) {
+		atomic_set(cnt, 0);
+		smp_store_release(slot2, 1);
+	}
+}
+
+exists (0:r1=-1 /\ 2:r0=1 /\ 1:r0=1 /\ 1:r1=0 /\ 1:r2=1)
diff --git a/Documentation/litmus-tests/fs/file-ref-put-release-handoff.litmus b/Documentation/litmus-tests/fs/file-ref-put-release-handoff.litmus
new file mode 100644
index 000000000000..51c3e9d533a6
--- /dev/null
+++ b/Documentation/litmus-tests/fs/file-ref-put-release-handoff.litmus
@@ -0,0 +1,66 @@
+C file-ref-put-release-handoff
+
+(*
+ * Result: Sometimes
+ *
+ * file-ref-put-full-handoff.litmus with a release-ordered decrement,
+ * atomic_long_dec_return_release().  The release orders the cleared
+ * slot before the decrement itself and nothing more: not before the
+ * freelist store that hands the object to the other CPU, which is a
+ * later plain store.  So the other CPU can take the object, set ONEREF
+ * and publish it while the cleared slot is still invisible, and the
+ * lookup that incremented the recycled counter passes its recheck with
+ * the old slot and keeps a reference to a file the descriptor never
+ * named.  The deferred path of fput() gets such a barrier from the
+ * try_cmpxchg() of task_work_add(); the synchronous paths have nothing
+ * but the decrement.
+ *)
+
+{
+	atomic_t cnt = ATOMIC_INIT(0);
+	slot=1;
+	slot2=0;
+	fl=0;
+	0:r1=-9;
+}
+
+P0(int *slot, int *fl, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*slot, 0);
+	r0 = atomic_fetch_sub_release(1, cnt);
+	if (r0 == 0) {
+		r1 = atomic_cmpxchg_release(cnt, -1, -4);
+		if (r1 == -1) {
+			WRITE_ONCE(*fl, 1);
+		}
+	}
+}
+
+P1(int *slot, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*slot);
+	r1 = atomic_fetch_add_acquire(1, cnt);
+	r2 = READ_ONCE(*slot);
+	rcu_read_unlock();
+}
+
+P2(int *slot2, int *fl, atomic_t *cnt)
+{
+	int r0;
+
+	r0 = READ_ONCE(*fl);
+	if (r0 == 1) {
+		atomic_set(cnt, 0);
+		smp_store_release(slot2, 1);
+	}
+}
+
+exists (0:r1=-1 /\ 2:r0=1 /\ 1:r0=1 /\ 1:r1=0 /\ 1:r2=1)
diff --git a/Documentation/litmus-tests/fs/file-ref-reload-dep-field.litmus b/Documentation/litmus-tests/fs/file-ref-reload-dep-field.litmus
new file mode 100644
index 000000000000..805d977f52ac
--- /dev/null
+++ b/Documentation/litmus-tests/fs/file-ref-reload-dep-field.litmus
@@ -0,0 +1,74 @@
+C file-ref-reload-dep-field
+
+(*
+ * Result: Never
+ *
+ * The recheck of __fget_files_rcu() passes when the file was recycled
+ * into the same descriptor: thread A closes fd and opens again, gets the
+ * same struct file and the same fd back, and thread B looks fd up
+ * meanwhile.  B's increment lands on the recycled file and the reload
+ * sees the slot hold that file again, which is fine, the descriptor
+ * does name it now.  But the fields of the file that B's caller reads
+ * next have to be the new incarnation's.  init_file() sets f_ref before
+ * do_dentry_open() stores f_op, and what publishes f_op is the release
+ * store of fd_install(), the one the reload saw.  So the field read has
+ * to depend on the reload, not on the first load.
+ *
+ * P0 is thread A: close() clears the slot, fput() marks the file DEAD
+ * and frees it, open() recycles it: init_file() stores ONEREF, the
+ * plain store of f_op follows, fd_install() publishes the slot.  P1 is
+ * thread B: the first load of the slot, the acquire-ordered increment,
+ * the reload and the compare, then f_op read through the reloaded
+ * pointer, as __get_file_rcu() does and as __fget_files_rcu() does since
+ * the reload became the pointer it returns.
+ *
+ * The slot holds a pointer to fop, the f_op field, or to q, NULL; fop
+ * is 1 in the old incarnation and 2 in the new one.  The address
+ * dependency of the field read on the reload orders it after the
+ * release store the reload read from, so it returns 2.
+ *)
+
+{
+	atomic_t cnt = ATOMIC_INIT(0);
+	slot=fop;
+	fop=1;
+	q=0;
+	0:r1=-9;
+	1:r3=-9;
+}
+
+P0(int **slot, int *fop, int *q, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*slot, q);
+	r0 = atomic_fetch_sub(1, cnt);
+	if (r0 == 0) {
+		r1 = atomic_cmpxchg_release(cnt, -1, -4);
+		if (r1 == -1) {
+			atomic_set(cnt, 0);
+			WRITE_ONCE(*fop, 2);
+			smp_store_release(slot, fop);
+		}
+	}
+}
+
+P1(int **slot, atomic_t *cnt)
+{
+	int *r0;
+	int r1;
+	int *r2;
+	int r3;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*slot);
+	r1 = atomic_fetch_add_acquire(1, cnt);
+	r2 = rcu_dereference(*slot);
+	if (r2 == r0) {
+		r3 = READ_ONCE(*r2);
+	}
+	rcu_read_unlock();
+}
+
+exists (0:r1=-1 /\ 1:r0=fop /\ 1:r1=0 /\ 1:r2=fop /\ 1:r3=1)
diff --git a/Documentation/litmus-tests/fs/file-ref-reload-nodep-field.litmus b/Documentation/litmus-tests/fs/file-ref-reload-nodep-field.litmus
new file mode 100644
index 000000000000..a67c369b683e
--- /dev/null
+++ b/Documentation/litmus-tests/fs/file-ref-reload-nodep-field.litmus
@@ -0,0 +1,59 @@
+C file-ref-reload-nodep-field
+
+(*
+ * Result: Sometimes
+ *
+ * file-ref-reload-dep-field.litmus with f_op read through the pointer of
+ * the first load, which is what __fget_files_rcu() returned between
+ * 253ca8678d30 and the reload becoming the pointer it returns.  The
+ * field read is ordered after the increment by the acquire, and a fully
+ * ordered increment does no better, but nothing ties it to the reload
+ * and so nothing ties it to the release store of fd_install() that
+ * published the new f_op.  The lookup returns the recycled file and the
+ * caller reads the old incarnation's f_op.
+ *)
+
+{
+	atomic_t cnt = ATOMIC_INIT(0);
+	slot=fop;
+	fop=1;
+	q=0;
+	0:r1=-9;
+	1:r3=-9;
+}
+
+P0(int **slot, int *fop, int *q, atomic_t *cnt)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*slot, q);
+	r0 = atomic_fetch_sub(1, cnt);
+	if (r0 == 0) {
+		r1 = atomic_cmpxchg_release(cnt, -1, -4);
+		if (r1 == -1) {
+			atomic_set(cnt, 0);
+			WRITE_ONCE(*fop, 2);
+			smp_store_release(slot, fop);
+		}
+	}
+}
+
+P1(int **slot, atomic_t *cnt)
+{
+	int *r0;
+	int r1;
+	int *r2;
+	int r3;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*slot);
+	r1 = atomic_fetch_add_acquire(1, cnt);
+	r2 = rcu_dereference(*slot);
+	if (r2 == r0) {
+		r3 = READ_ONCE(*r0);
+	}
+	rcu_read_unlock();
+}
+
+exists (0:r1=-1 /\ 1:r0=fop /\ 1:r1=0 /\ 1:r2=fop /\ 1:r3=1)

-- 
2.53.0

