Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884712;
	b=46YKMtlE4ScwieXcINNh4a8bbjkkIpQzCDvCbRe7FuzenJ7bZLWsycrwVFPMw2x+gJgk
	 uMdAzNo4D7zh6mj3jYd8T7kgKLTZg5Bjb2uBslsNUemjWPQc0f4mE/+gzM/+i+ICe1njv
	 TJlHXd7LqMevEog32k4QKsoLZbJdN3vzu9dMTB1Mv7uylCVm9Wc/ynTmNJ3O9JhGcFnRb
	 ZLDt+cgMPLJDUrnjnASomE2XJWUVUZNNggXUgE5Pm6m6qwl2MJBaZMhsU0mkiJ3wNE/LT
	 CP398Lbt6H1Qb3zrjq4+8da6A06k5d2WPBVEcIdCmCrOIEzkI+MPU7t0mD4OMhYoQPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884712;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ozDE69mxIoGwhcyK2c128JoWzobDSlOBs9tdnoi4aO0=;
	b=mIu591NPlbla26pUcBvDxJ/TSHoVC2lym0rPHQk1fI3F/qo1yr17P8Y8Bv8ZmH+IXnpF
	 atJzRR3lN8WFmwUiBgfctnHzULT03VJxjiU+XQsZ4nhlyOVrLB3c+WBqUNkbqQAK5Eo+K
	 4+gBxCO3yz2gr+HvcH8wsYjomWpGqoLRtAblSNxfoHlrdNliaSoNcocZas5ilgJTCYogp
	 P1GylNCzUEv+b+AvmSvbRafVaUz8Uy3PGoL7+6crtXzOY6AF1MpSs0UiN0BQvZWYrm9rP
	 f/MLW7+IcRuhCC6lvYCJxQl50b63W9rq4Y+J5gmWpd/LcxcIUur8EpSpQCMj482tQcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XE2fL8iA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C36606A330
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XE2fL8iA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71971F00919;
	Thu,  5 Nov 2026 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884712;
	bh=ozDE69mxIoGwhcyK2c128JoWzobDSlOBs9tdnoi4aO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XE2fL8iA6YNYG5TB7cAxRyUp9qIs1tZKDWgyHZPnXZ5i3NiowR28GqCzyRWu0UO2t
	 KKZtajqcpG/u/aXnaFRhMdNxK4pbSKdFyDpPqJ0/HhrIqDfPUUUfODwOrmBya5O2Y0
	 ISmawnwcre+UswwUj8IA8jVk6arxWIKuUktpHKKwdtXeNSp/SbpG2uROL3tqZe9eOC
	 Rr/ZJFhpF0BWxCfON2TfTVLuZQexHH7JMzsvFSbmNU3OTW51B5YlUt0g+fyiTNxcOO
	 92w7kR14E49bPSunI35qztyOQ04Lauj8xcWuzp8l+HNM4aOwsAN6SIkyVXSM1bzHST
	 FlnwqQcI2Ju1w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Nov 2026 14:18:05 +0100
Subject: [PATCH 1/5] file: depend on the reloaded pointer in
 __fget_files_rcu()
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
Message-Id: <20261105-work-file_ref-ordering-v1-1-8713f4876b7b@kernel.org>
References: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
In-Reply-To: <20261105-work-file_ref-ordering-v1-0-8713f4876b7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3277; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ggy6tKGgKbJu49tAfyH3ra7ZC2ISXRxZdejygrIGq9I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9aZJ1ucKUNSHubIC/xrVdkj1Jqb7n2vPcQq4uvaW0/
 vAnafeGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkIbWFkOMsU+8xJkq353N85
 ZTJ6GcLNhoqaXLds9TMFbT5aKFsHMDJcUry/dFFs+SL9WMa9L+2ep3QeS+rpD1qxv6Q+XGF5BRc
 vAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

__fget_files_rcu() loads the file pointer, takes a reference with
file_ref_get(), reloads the pointer and compares the two. If they match
it returns the pointer of the first load. The caller will read f_mode,
f_op and everything else through.

Becuase of SLAB_TYPESAFE_BY_RCU the file can be closed, freed and
reallocated between the first load and the increment. If another thread
of the same process reopens the same descriptor the reload can see the
same pointer again and the recheck passes.

While that's fine because the descriptor does point to that file now the
subsequent loads are only ordered after the increment.

The increment synchronizes with the store of file_ref_init() and
init_file(). But that happens before do_dentry_open() sets f_op and most
of the other fields.

They are published by the rcu_assign_pointer() in fd_install() meaning
the reload of the pointer.

But there's no dependency between the reload and later loads. So on
arm64 or power the caller can read the f_mode and the f_op of the
previous lifetime of the file.

So we do need to compare against a copy the compiler can't see through
and then use the reloaded pointer from there on just like we already do
in __get_file_rcu().

Nothing measurable changes because of this change.

Fixes: 253ca8678d30 ("Improve __fget_files_rcu() code generation (and thus __fget_light())")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 4cd40dfa6129..052da9409874 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1168,6 +1168,8 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 {
 	for (;;) {
 		struct file *file;
+		struct file *file_reloaded;
+		struct file *file_reloaded_cmp;
 		struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 		struct file __rcu **fdentry;
 		unsigned long nospec_mask;
@@ -1216,11 +1218,32 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 *
 		 * If so, we need to put our ref and try again.
 		 */
-		if (unlikely(file != rcu_dereference_raw(*fdentry)) ||
+		file_reloaded = rcu_dereference_raw(*fdentry);
+
+		/*
+		 * Every load needs to depend on the reload. If the
+		 * file was freed and reallocated into this slot in the
+		 * meantime, what open() wrote to it was published by the
+		 * rcu_assign_pointer() in fd_install(), which is the
+		 * store the reload saw.
+		 *
+		 * The increment above only orders against file_ref_init()
+		 * and init_file(). That happens before do_dentry_open()
+		 * sets f_op et al. So every load needs to depend on the
+		 * reload otherwise we can see e.g., stale f_op on e.g.,
+		 * arm64.
+		 *
+		 * So compare against a copy the compiler can't see through
+		 * and use the reloaded pointer from here on.
+		 */
+		file_reloaded_cmp = file_reloaded;
+		OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
+		if (unlikely(file != file_reloaded_cmp) ||
 		    unlikely(rcu_dereference_raw(files->fdt) != fdt)) {
 			fput(file);
 			continue;
 		}
+		file = file_reloaded;
 
 		/*
 		 * This isn't the file we're looking for or we're not

-- 
2.53.0

