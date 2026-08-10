Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A61E9B1A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786321389; cv=none; b=FYeiUURatwG9jTsCepNBauWqvrlMK0stfLN8XMECy3jdq8icY46+xDhvPuMgQAzp2OOQXPAaQlBBIYG3ytfTqz3O4QnbhF+hvkq6DO6opFzSzi+uhlN7TYbiUE+t7Btrc3pPTJZLsY5p1uXstE+pvzyn4N+7/H5YuG/mfj0fvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786321389; c=relaxed/simple;
	bh=k21sPb48usHdoyH+HWwqXvykfiYfhfVhDPc25Uayv1E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V0t42hNQm8zZDglL+osX9k12yL191A9Y7Wk6vlW3BATjhPJudilFKl+CHbwRN+JV+pQkGzIi6vtoqeX1Cwdkf8CkxOb4i7bL05au5V9WHTSA2S5Dtpv52g7Jvm4as4Wf0lDLD470L5ibRVy7LPYYpTUhqY9CsHwihsFUaYRqKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRm+KE59; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRm+KE59"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84eb992a881so788041b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786321387; x=1786926187; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OR/NeAT70AXkJxV5qLrjC7wfN9T2B+VjuoviUV573+o=;
        b=HRm+KE59rV30z9muzdAdxTyn3eBZrfpPobNe0M3GMF33GCklr9uhnOB4qUSciKNzSD
         ckZmU4vB72VrxCgHh09hJmVjssHwi3cyN6e2N90wzYxddpM/VWjAl/NZzS1JNR24VGTr
         0WZeFRSEqr6E66FDU29i2QQ+hMc97prgKc9VFyE8jJ42SMwDjx4VB/pkCtsgQgMzLhD6
         +UtqyIqec36cDG3xMehZm5LY8FdGviUfaaWjSR/EdYSIKDdWwpgpzb0jOR4rdXE7CWna
         ouUbrG8EuMZTUvJVYPm0w3KI+LAhqjRUU9KQFSc0FtdqSF4vbOGZJ/NZZ/I4TCI45+By
         b8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786321387; x=1786926187;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OR/NeAT70AXkJxV5qLrjC7wfN9T2B+VjuoviUV573+o=;
        b=NNDz3b2+UI73zuy9OLK1AC8crZ56hfry8RPLNVfgDvpWC+E7QnOMJnQf74hND/IFL9
         ySdbEWzRi/BRT/doIEQKpEzSKoJXMCjKg0Fh/5McAgPni+lzhyT75ecx4CSrcqst0jK1
         eeNDdTe1RBUnAYXcK9IYbfrhXufVQLGXHqqzDCR3nUpJvdgkYBHb7qCRr6EHz/+Q5HtC
         F93SJtxg+E46UZIEIT6lj+JSDKSWESp5ZEUExjiBiysmxv++ZASh8IVJVvfORMweJfIh
         78EhqSt0x+r66ipLwRnvL0k5/6CGF9Icbe6Ims+gDi/w/D1cfnNIYPpBQ760aiDb5W7I
         omtA==
X-Gm-Message-State: AOJu0Yx/65YUQe/I88WqRVLuNY92NECWoavEgYeJHL16SG2sLFnKfNet
	BzxaGZxF+/jvcjrzBUBB7BZ3u6BqfCieTh4cviPPb0ztl4y7R5qM06Rt
X-Gm-Gg: AR+sD13Accz5vZ6hhsYjbWsIkokE5Qum6XCXGi5pYoYWqnSKcicIvMzVMX7kjP7BsAE
	Bam1VsyzHSxMT5VdB82n5AcVj+gLYnCPidzWFnrj6PC6lP/fBZ90B9PCGWdAPjcrLaa/LFsBeyk
	COTw2zj8YmBlhtl/haWAMLcwpTfNpR4BohqoH4bhGMwn3mRpOOnzxCvFiAAjXhA/ocJMB9i0VIz
	S9jpX0lfW6rL4nu+djfml9nh09aoLq3IGUCco4Ps0f/oRD8ARtMFYq/wyF3qxws9WRi3e9CtSH4
	tTCLPlZR5H6nDFdh0CcSQUHdDilPs/ccursre9iJQYNlm3KwSjlw9/hSumH2iFJdTBPqjhWS3uX
	yLgSzh+01TpLExap+8OuyaS7+HedmtBZyDFTgIiJufdyEt60yrNFRrkDFAweM0qX4YO3/gqFNv8
	EEzJz4TveJt1A80dPbH6xa3QwzOuG1yUNJDpETgCFJq1LFSUBHFAdq3LkZIEzvktdQyVrc0ijpu
	AfxdO/4
X-Received: by 2002:a05:6a00:2d9a:b0:848:70dd:f5a9 with SMTP id d2e1a72fcca58-84f4fee2fd9mr26312460b3a.38.1786321387379;
        Sun, 09 Aug 2026 17:23:07 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f753b7dacsm1248234b3a.41.2026.08.09.17.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:23:06 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:23:01 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tglx@kernel.org,
	mingo@redhat.com, peterz@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, akpm@linux-foundation.org, david@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] futex: Keep the PI owner of a private futex in the key's
 mm
Message-ID: <ankZ5euBcxDo0-Zq@v4bel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The futex word read by the FUTEX_LOCK_PI operations can hold an arbitrary
TID. For the task looked up by that TID, attach_to_pi_owner() only checks
whether it is a kernel thread and whether it is already exiting. It does
not verify that the task belongs to the address space the futex key was
taken from.

A private futex key is the pair (mm, address), and the mm is stored as a
plain pointer without taking a reference. __attach_to_pi_owner() copies
that key into the pi_state by value and links the pi_state onto the
owner's futex.pi_state_list. The pi_state can therefore hold a key of an
mm which is not the owner's, either because the TID named a task in
another mm to begin with, or because exec_mmap() installs a new mm on the
owner after the attach. de_thread() runs before exec_mmap(), so the waiter
in the latter case is not a thread but a sibling that only shares the mm.

When the owner exits, exit_pi_state_list() pins the private hash of the
owner's mm with guard(private_hash)(current->mm), but resolves the hash
bucket from the key stored in the pi_state, which points at the waiter's
mm (M below). The stored key holds no reference on M, and
futex_hash_free() does not look at the fph references still outstanding.

  T1 (waiter, CLONE_VM sibling)     T2 (owner, mm = M -> new_mm)

  clone(CLONE_VM)   // creates M's private hash

                                 execve()
                                   exec_mmap()
                                     exec_mm_release()
                                       futex_exec_release()  // STATE_OK

  futex_lock_pi()
    attach_to_pi_owner()   // p->mm == key->private.mm
      pi_state->key = *key   // {M, addr}
      list_add(&pi_state->list, &T2->futex.pi_state_list)

                                     tsk->mm = new_mm
                                 do_exit()
                                   exit_pi_state_list()
                                     guard(private_hash)(current->mm)
                                     key = pi_state->key   // M
                                     CLASS(hbr, hbr)(&key)
                                     hb = hbr.hb           // +refcount

  do_exit()
    exit_mm()
      mmput(M)
        __mmput(M)
          futex_hash_free(M)
            kvfree(fph)

                                     spin_lock(&hb->lock)  // UAF

A private futex only has meaning inside the mm its key was taken from.
Verify in attach_to_pi_owner() that the candidate owner belongs to the mm
of the private key and return -ESRCH otherwise, as the TID is then simply
a bogus user space value. p->mm is not protected by p->pi_lock, so it is
read with READ_ONCE(), and the check is placed after the exit state check.
That check alone does not stop exec, so futex_exec_release() is split into
begin/end to keep FUTEX_STATE_EXITING set until the mm has been swapped.
An attach in that window gets -EBUSY, retries, and then fails the check
against the new mm. Fixing only one of the two leaves the same
use-after-free reachable through the other path.

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local hash")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Also keep FUTEX_STATE_EXITING set across the whole exec transition. v1 only
validated at attach time, and a successful execve() invalidates that
afterwards, so the same use-after-free stayed reachable with v1 alone.
futex_exec_release() is split into begin/end, and every exec_mmap() unwind
calls the end half.
- Rewrite the commit message to cover both paths.
- v1: https://lore.kernel.org/all/angLZrg_1yeCW0ig@v4bel/
---
 fs/exec.c             | 7 ++++++-
 include/linux/futex.h | 8 ++++++--
 kernel/fork.c         | 2 +-
 kernel/futex/core.c   | 8 +++++++-
 kernel/futex/pi.c     | 7 +++++++
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c7b8f2d6366c44..42eb98fbd12593 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,6 +65,7 @@
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
+#include <linux/futex.h>
 #include <linux/time_namespace.h>
 #include <linux/user_events.h>
 #include <linux/rseq.h>
@@ -857,8 +858,10 @@ static int exec_mmap(struct linux_binprm *bprm)
 	exec_mm_release(tsk, old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
-	if (ret)
+	if (ret) {
+		futex_exec_release_end(tsk);
 		return ret;
+	}
 
 	if (old_mm) {
 		/*
@@ -869,6 +872,7 @@ static int exec_mmap(struct linux_binprm *bprm)
 		ret = mmap_read_lock_killable(old_mm);
 		if (ret) {
 			up_write(&tsk->signal->exec_update_lock);
+			futex_exec_release_end(tsk);
 			return ret;
 		}
 	}
@@ -896,6 +900,7 @@ static int exec_mmap(struct linux_binprm *bprm)
 		local_irq_enable();
 	lru_gen_add_mm(mm);
 	task_unlock(tsk);
+	futex_exec_release_end(tsk);
 	lru_gen_use_mm(mm);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 51f4ccdc909272..324f49493cbb43 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -72,7 +72,10 @@ static inline void futex_init_task(struct task_struct *tsk)
 
 void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
-void futex_exec_release(struct task_struct *tsk);
+void futex_exec_release_begin(struct task_struct *tsk)
+	__acquires(&tsk->futex.exit_mutex);
+void futex_exec_release_end(struct task_struct *tsk)
+	__releases(&tsk->futex.exit_mutex);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
@@ -90,7 +93,8 @@ static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
-static inline void futex_exec_release(struct task_struct *tsk) { }
+static inline void futex_exec_release_begin(struct task_struct *tsk) { }
+static inline void futex_exec_release_end(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 			    u32 __user *uaddr2, u32 val2, u32 val3)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index f0e2e131a9a5af..d2736b24ff7520 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1510,7 +1510,7 @@ void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
 
 void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
-	futex_exec_release(tsk);
+	futex_exec_release_begin(tsk);
 	mm_release(tsk, mm);
 }
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 128c5752f225c2..a920dfbd0390d5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1539,7 +1539,8 @@ static void futex_cleanup_end(struct task_struct *tsk, int state)
 	mutex_unlock(&tsk->futex.exit_mutex);
 }
 
-void futex_exec_release(struct task_struct *tsk)
+void futex_exec_release_begin(struct task_struct *tsk)
+	__acquires(&tsk->futex.exit_mutex)
 {
 	/*
 	 * The state handling is done for consistency, but in the case of
@@ -1550,6 +1551,11 @@ void futex_exec_release(struct task_struct *tsk)
 	 */
 	futex_cleanup_begin(tsk);
 	futex_cleanup(tsk);
+}
+
+void futex_exec_release_end(struct task_struct *tsk)
+	__releases(&tsk->futex.exit_mutex)
+{
 	/*
 	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
 	 * exec a new binary.
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 795011ea1202f1..d97611196b34ac 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -465,6 +465,13 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_MMU) && futex_key_is_private(key) &&
+	    READ_ONCE(p->mm) != key->private.mm) {
+		raw_spin_unlock_irq(&p->pi_lock);
+		put_task_struct(p);
+		return -ESRCH;
+	}
+
 	__attach_to_pi_owner(p, key, ps);
 	raw_spin_unlock_irq(&p->pi_lock);
 
-- 
2.43.0

