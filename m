Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884720;
	b=HYc9Pe35yC58hNTHCTpoRD4k/hCi6gzDSfT6FQOz57sE+9mEQlwCfx4P24YLS9Y5Q5JP
	 I3H9LQRjy+osRESuHPRhO1hAeAe3w3TlNuXzmIkeFi/kE6LqZ3HDaONEjPNMEADvtQ2aw
	 U4ykfXb/ILKLJxl76VCrvUkbQisZAPLrOg2SedKtXEeGRVwXbPYyQ4PQkAyzgsMzRj8jD
	 ED2PWTVz4sAv1IEPvf/L1ip6Fa5hG/L32teFD83uwCbTEqdBIIKffjGQFVR1jtgh9F9AT
	 dWnOf+s60u9cpXmUE/WkW1ZbZTuH24IZ8mW0P54CobceFqoYpkzVYvsVR1Ss1vGzgTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884720;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/IpIdp4OE9/3JMRCiRDnYppRpxl4gzgVqjuSin89EMU=;
	b=Z870tIBsZtdZq1DFsdEyaBZj28EYucllhAkxkeuD/aOLetOAJZScKeXpvjccvIrCZWbw
	 AMy64S8y+s79b6x8cuqkXGRAZPfZAMp6WDtU5bVJZsLtDayz7pfVDgmHOqdFoEbBbY9ee
	 GjLV0UtEPtFoOirWJygmvlfOu44gfaOv/LdIShjINVvn/C5cG/AmD1qO202sDDj3/j7n/
	 kXvBTqqbXy86qtdgDyM0XK6k2+ZQKECTPzk1U+EEdE/NTsuq0Is5mDfCTqFQrV3hbIbcw
	 FzXsZHRc6cW1znIP8XeEetKcuypV9b5geJCBdo/3HQfb4Pffvy40KCnmCiwArJsXgNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rp93meuh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1B606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rp93meuh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE21F0093A;
	Thu,  5 Nov 2026 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884719;
	bh=/IpIdp4OE9/3JMRCiRDnYppRpxl4gzgVqjuSin89EMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Rp93meuh+vlI8o3F/ygwpP8QfT1pDpZfej9mI6gft0AduL77AdpAylgZ2PgXReHOi
	 MqgNMG/GIUNPjWpJP0CgjNRHb2Ea6fxQfFjPfkDAuczZxu1eCGWhaxmLlEAEVH3YoI
	 UG22zowq3JieEpMpkLvzya1jOHfoE/NJDx0byCSVS9HiuOjoVsx4i5IEhZVhIfrps8
	 Gvc40o/nahYCGpEu4FhQqyzJ9vlCE82uFmrCKwwITA5JEX1qkg8D4VxptS0eRcEBX3
	 123j2fOhnQwAwAN/zirqUuIBAIBadKC3iOfMfSLLvIa4ahe9zu8eny/FbfrKh2uxZN
	 RHIQx064Q6lCg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Nov 2026 14:18:09 +0100
Subject: [PATCH 5/5] Documentation: update the lock-free file lookup in
 files.rst
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
Message-Id: <20261105-work-file_ref-ordering-v1-5-8713f4876b7b@kernel.org>
References: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
In-Reply-To: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4966; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OyunjCzv375rlmOf+3Me2voNUK5N77Tkr7WALcPk1v8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9aVIsm3rj6+cIKe1ZHx98jzF5POvY6bBV3PGPFPfZ9
 qwqWbTGpaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiKtIM/4zLNdXSFy5Y0p/A
 lmG4VSOOOdz0W3x73VdXB4/SR7xyHowMq6bzHn+pzVSZzvVGs2n1pNICpXnP2LmyPBgbAv2ur0t
 mBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The lock-free lookup section of files.rst still sends readers to the
lookup_fdget_rcu() helpers that commit 8fd3395ec905 ("get rid of
...lookup...fdget_rcu() family") removed. And the SLAB_TYPESAFE_BY_RCU
paragraph still describes the reference as atomic_long_inc_not_zero()
and points to __files_get_rcu(), which doesn't exist, the lookup is
__fget_files_rcu(). Files have been using file_ref since commit
90ee6ed776c0 ("fs: port files to file_ref").

So point readers to fget() and friends and spell out what the lookup
does now: take the reference with file_ref_get(), reload the pointer,
compare against a copy the compiler can't see through and return the
reloaded pointer. Then say which orderings that rests on, the acquire
in file_ref_get(), the dependency on the reload and the full ordering
of file_ref_put(), and where they are documented and checked:
include/linux/file_ref.h and Documentation/litmus-tests/fs/.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/filesystems/files.rst | 48 +++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
index eb770f891b27..59536e62ed74 100644
--- a/Documentation/filesystems/files.rst
+++ b/Documentation/filesystems/files.rst
@@ -61,29 +61,32 @@ the fdtable structure -
 3. For any update to the fd table, files->file_lock must
    be held.
 
-4. To look up the file structure given an fd, a reader
-   must use either lookup_fdget_rcu() or files_lookup_fdget_rcu() APIs. These
-   take care of barrier requirements due to lock-free lookup.
+4. To look up the file structure given an fd, a reader must use one of
+   the fget() helpers: fget(), fget_raw(), fget_task(), fget_task_next()
+   or fdget() and friends. These take the reference and take care of
+   the barrier requirements of the lock-free lookup.
 
    An example::
 
 	struct file *file;
 
-	rcu_read_lock();
-	file = lookup_fdget_rcu(fd);
-	rcu_read_unlock();
+	file = fget(fd);
 	if (file) {
 		...
-                fput(file);
+		fput(file);
 	}
 	....
 
+   fdget() skips the reference when the file descriptor table isn't
+   shared, see the comment above __fget_light() for the rules that come
+   with that. Under files->file_lock a file can be looked up without a
+   reference with files_lookup_fd_locked() as long as the lock is held.
+
 5. Since both fdtable and file structures can be looked up
    lock-free, they must be installed using rcu_assign_pointer()
    API. If they are looked up lock-free, rcu_dereference()
    must be used. However it is advisable to use files_fdtable()
-   and lookup_fdget_rcu()/files_lookup_fdget_rcu() which take care of these
-   issues.
+   and the fget() helpers which take care of these issues.
 
 6. While updating, the fdtable pointer must be looked up while
    holding files->file_lock. If ->file_lock is dropped, then
@@ -105,15 +108,24 @@ the fdtable structure -
    Since locate_fd() can drop ->file_lock (and reacquire ->file_lock),
    the fdtable pointer (fdt) must be loaded after locate_fd().
 
-On newer kernels rcu based file lookup has been switched to rely on
-SLAB_TYPESAFE_BY_RCU instead of call_rcu(). It isn't sufficient anymore
-to just acquire a reference to the file in question under rcu using
-atomic_long_inc_not_zero() since the file might have already been
-recycled and someone else might have bumped the reference. In other
-words, callers might see reference count bumps from newer users. For
-this is reason it is necessary to verify that the pointer is the same
-before and after the reference count increment. This pattern can be seen
-in get_file_rcu() and __files_get_rcu().
+Files are allocated from a SLAB_TYPESAFE_BY_RCU cache since commit
+0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU"). Freeing a file
+doesn't wait for a grace period anymore. The memory can be handed out
+again right away and only the type of the object is stable under
+rcu_read_lock(). So it isn't sufficient to take a reference on the file
+found in a descriptor slot. The file might have been closed, freed and
+recycled in the meantime and the reference lands on whoever owns the
+object now. The lock-free lookup in __fget_files_rcu() and
+__get_file_rcu() therefore:
+
+(1) loads the pointer from the slot and takes a reference with
+    file_ref_get(), which fails if the file is dead,
+
+(2) reloads the pointer and compares it against the earlier load, if they
+    differ the file was recycled and the reference is dropped again, and
+
+(3) returns the reloaded pointer so that everything the caller reads
+    from the file depends on the reload.
 
 In addition, it isn't possible to access or check fields in struct file
 without first acquiring a reference on it under rcu lookup. Not doing

-- 
2.53.0

