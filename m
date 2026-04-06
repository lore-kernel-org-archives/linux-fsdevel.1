Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE338B12C;
	Mon,  6 Apr 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493872; cv=none; b=kR9sZfWf1jrCipPuZfEhSdlO7G++njo5N1kZc9pXz3HA35Rx7Uk6pbQJHii+xJz3oH/EkG8ZHbDVGFdsCxQK2gFXSeATzdrQpHrYUFPgDRhqLHIzfb5BW/LcMrwVuhsjsLz3Ki9qXaRIVr/ECA0L2WfT1YfNhgSC5uxTWiIT4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493872; c=relaxed/simple;
	bh=r1SCxjwjTORKq97VFYNjRcFgpK6Hv0Snxcfs/RwaZqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kqCJ3AHU34/Qj2snqsM8T//LJEFIEvkR4ksL8KfbomLGvEUnuhjnwiDoSuElwqidYO8Kr5O9DYZwXyI/cJrGJ5zkt4S3pd1ihGi0+M2usLUXFE/yE1eASOdFtmgKQChGJspYFuuD3oFkEuHg2rpdyr+bt8v/WIBakAAyViVn2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7Avl2v3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7Avl2v3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92966C4CEF7;
	Mon,  6 Apr 2026 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775493872;
	bh=r1SCxjwjTORKq97VFYNjRcFgpK6Hv0Snxcfs/RwaZqg=;
	h=From:Date:Subject:To:Cc:From;
	b=P7Avl2v3PEJfns8R1sPOOkf88Mi+/7TTek+6uFd7cHoKFR+S7NgmHkSyceIb+wm7P
	 y1ZZo6kDTKJ4LtRX9m4qQB0gxfq/5Ln8sGdrts806ovi+qnZoZp9Coze1GpKrWZ69j
	 rCWGZhozrxjhEG4CKOVdJravmUuZIkMuH8kdwXEqsivzC6LsulZmEqvcesetP+Bb4Q
	 QfW/WxWHiBDN9DNqU/HpWFiLqPCeIjcNfeIb6JkvYpUP5996XnJ4HMC/143JJyrkp5
	 cOJ7oswxJfAn0jdJRpwrYgeZeE+ChiJ71TTHvW5abF6hE3YEuRUrycT0Nw0UcCrRbz
	 uiQ3oUOyU/+XA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 06 Apr 2026 12:44:13 -0400
Subject: [PATCH] dcache: warn when a dentry is freed with a non-empty
 ->d_lru
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNj3ZTkxOSMVN3yxKI83UQTS+Mkg1TjZAtzcyWgjoKi1LTMCrBp0bG
 1tQAYhtUvXQAAAA==
X-Change-ID: 20260403-dcache-warn-a493b0e3c877
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=r1SCxjwjTORKq97VFYNjRcFgpK6Hv0Snxcfs/RwaZqg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp0+LqDYWkqmhspgUjyPJTXHY/Lt2+2IdF561U9
 vk75qDsL2uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadPi6gAKCRAADmhBGVaC
 FTKNEAChMfvrU6aAyFk7sI5SC6hOYJ94eywf6gsZ8xylSLIsQSI2ZDMixsFjChIAJSorRXdNymJ
 tli4cDRZjkeJzSogSdpn0Mh6Fr9kWJZQ7BIvUwWAJaqYw37Ngr6QoqopiWvee+p9MU5DHp6PBiG
 SYR8L+eF55DEHvtqBAFuc7H8vfd9W88WwlDh66+NQArKzoxaceZKVSoBxbz+vhHoWw5tsHqrcXE
 TNb+MlkWKrKqdKJbvwRm+Ae4L68TKZ+bC4ojYVljguLAJsJODw57PRbYjKJB+JNJDUE1iDFUH9f
 3zMJTdD/iP1kmnTT470tLw4TcVS+C7GrQ5cIWCrXYE8tayt6t8/iiggkNov3klApbQcCWcJnswP
 xRvtiopKGj/69aRDe1TRWm1TD2gUH09pt4mpV0UyLO8GVd82INKjmmoQtP5pWhhuQ1btlOuKMKl
 B7XRVl/WyCXSNDD67cR0LOsINNSctrJNBbAEZ7TNgFHZyMIPCA25U4PlgpYlCDdfIq2VjRfPD/G
 SpLasN0nm/mjWosezMDUm8vwIozJ9xcXQkHOv8+jHmqUN89yD0AtLoAVZOjlDzlrC2qaj+/uN8h
 2//nUuJkA0H9w/Ez3e9/iwSP9RJwKVbfF5KrUA+8WimWupn7DlWzq7iLLmN8zCy6AB35J0z4yX0
 lr0ixogHR+L91+Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We've had a number of panics that seem to occur on hosts with heavy
process churn. The symptoms are a panic when invalidating /proc entries
as a task is exiting:

queued_spin_lock_slowpath+0x153/0x270
shrink_dentry_list+0x11d/0x220
shrink_dcache_parent+0x68/0x110
d_invalidate+0x90/0x170
proc_invalidate_siblings_dcache+0xc8/0x140
release_task+0x41b/0x510
do_exit+0x3d8/0x9d0
do_group_exit+0x7d/0xa0
get_signal+0x2a9/0x6a0
arch_do_signal_or_restart+0x1a/0x1c0
syscall_exit_to_user_mode+0xe6/0x1c0
do_syscall_64+0x74/0x130
entry_SYSCALL_64_after_hwframe+0x4b/0x53

The problem appears to be a UAF. It's freeing a shrink list of
dentries, but one of the dentries on it has already been freed.

The d_lru field is always list_del_init()'ed, and so should be empty
whenever a dentry is freed. Add a WARN_ON_ONCE() whenever it isn't.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
We've had some of these panics internally for a while. Additionally,
Claude also noted that these syzbot reports may be related:

    https://syzbot.org/bug?extid=0aee5e8066eddbbe7397
    https://syzbot.org/bug?extid=e8b3520b53e78e90034e
    https://syzbot.org/bug?extid=ad14fd37e76c579511d0

So far, I've been unable to spot the bug. Hoping this will make it
easier.
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..c6f475d940e3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -429,6 +429,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 static void dentry_free(struct dentry *dentry)
 {
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
+	WARN_ON_ONCE(!list_empty(&dentry->d_lru));
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
 		if (likely(atomic_dec_and_test(&p->count))) {

---
base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
change-id: 20260403-dcache-warn-a493b0e3c877

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

