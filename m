Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4ED31F9B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851978; cv=none; b=LO9uVuEJnb8+tx/O5nwXvFD7VjO5lbpJW7umKC4MPbfO5RRQU296dJcc4zxvvNBtmSvWHKi8GN1xnu5iAZ2xp1wFN/nkMauNvaAo6dsovabSklbeICYVd2KYlaP3rQL0NwVxIn9+G+QSTNa4SYpXkqvHg/miAmkOD6K3GxHahGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851978; c=relaxed/simple;
	bh=8S0WqBYgsz/IXuJMmY8zZuANSYouMAvcxS4w9tjsepw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jk9RhWR5I0I33g7IyzkvxbxARb3AXKC+z+LFHgsyrQT05o6hB4QBeUh4F8HDsOWyPl97+O5e2KuwByHsHOmFu8qEEHU6au/pjD2CuCI24zjTT0ZrHbbWpvxRCV7Zefayjx8UBfbvsNmx71KEttBSb1A2+C1eIkB8usuAYV+B7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHP4aLvN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHP4aLvN"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a1676000so1547953a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851977; x=1790456777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VUVHfzARqlh8tJ/q8PVOP34DDQA6F+c10lK4ubPRUgc=;
        b=PHP4aLvNOjYN7aUhkXznMKR1nehJGRlex+w+KpgZA71U3seJ7G+R8fG8T/4yA3f+r9
         yhabaAPZ12C5Nnk4UWKaKEUCn2u4eD8EiSZqAqOj0pTceNf7dEJNEZBM1JAS2ps52IVf
         BJ9rooZw3mG0EsikAiRW3lA97lCcS3G/XX7Dw+BMjmCwyUopY4wFx2CIgsJGOFnjOZde
         TZKhqhdmJuaVNM3Wm1crB8KYBCSr44T5eYOiggTfU1s/bg8ceje8dVsTdOEejAEI1J3F
         r55E0U6+M75HkIiWoIbDiQIUctaBQaQz++5Col/LIe05cmW8DttbB5NljIp6c9hibqT8
         +7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851977; x=1790456777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUVHfzARqlh8tJ/q8PVOP34DDQA6F+c10lK4ubPRUgc=;
        b=xwD22q5VRD3O6v0VT3Ww6jOJ6UXZvH8G9pTy/UhRyquw2SR+jfNbmMmXJeRKfk1H1D
         IwVB1fiLbb7Eb5pdF+o5e7pGsnwh/4ZKAQL2EJH8Hybovd9RHJWTvpERhtI0UUR38uTH
         FXt81di5HixBEk7401TV4dAGTR2fS2ZfFq+bDTBhqnNp7nmMb/MDHEAPulAVC+aBzPpM
         Gm5We4SqU8EEM5luMNEx+fVWIDmOhbPgVitoy3XfrwRdgrPU7qD9v6sfhFxv55Ci9ONf
         j7rI0mQzUeyuw7C25AbMRn/c0Gj/pctZAj4M5L8SP0QVsLZiHNqZNl0ddmDGeakDRmG2
         0guw==
X-Forwarded-Encrypted: i=1; AKwUvBwc0j99+Ca8bK9wCQnXu6y/EH4Cd0elQIyjuCoZ6KzwrAXTg03Sy9FA2inKStHB0nWjlGXd6+8vYL9HR1eC@vger.kernel.org
X-Gm-Message-State: AFuF++lNSOh6zHoo0otzMGGkj8OeOlWqEn+ifF9H1Q30cRSLSurLHNIM
	hg6fU+e69u93sBNYrSZ/7ZDBFnzTJTpz+zgMgjLw24hYBvnfbZvrG19M
X-Gm-Gg: AYBFou1xPyqS1abT8Z5af0jyT4esg/TnEiygvbn5F6uXjW5dhgJvWdhx9XPtba7sWoI
	SYx7jp7s7vWfH+zYSt+t9ijYR6vjAJdkvg5WUykdN+jF0ktOTxY2n+6B0/91zD+OoVpwY6JonhU
	poTLHriHqVVLXpz9QeX3nD/zWSMq7CvNbMPWFfmRlVcufMOMhqo/ZE3AmVR2MAYlTmzMMU+gKxd
	/OiQAyHTN2nb1WHawiD3KSe8bKv9MWOU5DnwM23bCIOLwz2LSkMpiP64tUFa5Vi8aXpf2EEfBGE
	lDwfk53zecLAiJd/R+4MmCfDnhMLrUtrizPV4E3wVFbaTqTDxoOb8LyjjOMun56AvGlvNY/FO+d
	pq+jRB+EoF9eDp0a20Oq9WM8/sHp8dqT5ljKVnAVGKvugqGsltMfNIlbE0Zzq8wqqs+yOwQfIdY
	gg+SLdKFYp7EQktxsJtu3///9feTteyOpEtiVDhelTfRGw479awmtFyRvNxs7MMQkOBm2Uw8c+z
	Ie/ds/sOx9Wri+53f6/zDKxu0Nzqhfxh7oCMATebKdzUYGoVgE8jhUd1/JjQf8mXYGvObbeGYIy
	hU9Y9Ac+PA==
X-Received: by 2002:a17:90a:c50:b0:39e:6a81:f351 with SMTP id 98e67ed59e1d1-39e6a81fd31mr3214241a91.43.1789851976881;
        Sat, 19 Sep 2026 14:06:16 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm5933883a91.11.2026.09.19.14.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:16 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	manfred@colorfullife.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/mqueue: remove pending notification in mqueue_evict_inode()
Date: Sat, 19 Sep 2026 21:06:15 +0000
Message-ID: <20260919210615.3028694-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a process registers a notification via mq_notify(), do_mq_notify()
takes references on info->notify_owner (struct pid) and
info->notify_user_ns (struct user_namespace), and for SIGEV_THREAD
notifications also allocates a 32-byte kernel sk_buff
(info->notify_cookie) charged via netlink_attachskb() to
info->notify_sock (struct sock).

mqueue_flush_file() only calls remove_notification(info) when the
process closing the descriptor has task_tgid(current) ==
info->notify_owner. When a child process created with CLONE_FILES (and
its own TGID) registers a notification via mq_notify() and exits while
the parent still holds the shared file table, exit_files() drops the
child's files_struct reference without calling filp_close(). When the
parent subsequently closes the descriptor and unlinks the queue,
task_tgid(current) != info->notify_owner in mqueue_flush_file(), so the
notification remains active when mqueue_evict_inode() is called.

Because mqueue_evict_inode() does not call remove_notification(info),
the attached sk_buff (and its sk_rmem_alloc charge on the netlink
socket), sock reference, pid reference, and user_namespace reference are
permanently leaked when the inode is evicted.

Call remove_notification(info) in mqueue_evict_inode() if
info->notify_owner is non-NULL.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 ipc/mqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index d1dd36a651b0..a49b7574e008 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -526,6 +526,8 @@ static void mqueue_evict_inode(struct inode *inode)
 	spin_lock(&info->lock);
 	while ((msg = msg_get(info)) != NULL)
 		list_add_tail(&msg->m_list, &tmp_msg);
+	if (info->notify_owner)
+		remove_notification(info);
 	kfree(info->node_cache);
 	spin_unlock(&info->lock);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

