Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A014A8FC7
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055330; cv=none; b=hbIQRfIO66nhdc1zjchpXUrXZLAychenPRE9SGKTgQeEmnCb2HSPCWFOLlw9zwuz2xpp5IA1nuVspEH9zNKxNSQ2fS3dEUes/+yhDTk203wakfeaaTlUHi/1mPX0pKGAEX8gKbd5ImeDLWJ6BAZPRM7UGs8lTNLB7JzEI1IDxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055330; c=relaxed/simple;
	bh=QApuKVgrVB1jXgqZkVjQ7A4FioHcx+RM/yMmJ5wv3yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGaCt8DrD3qfbDhUJDl6lvAWQvTddZm8Po1K//uFQsNvVsjac58/aNS5DqfFuQfWJZFTK0vOu++0ShGvRhgluZG+PKxk4XuwC6MoWUNWF5BaeuS/6aJSS4hnpAsnCsvZdm+U7mxLE2cNXO1tCVjBk4qZ8dBiX803ILbVkNFSrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLCpJ4rs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLCpJ4rs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F911F00893;
	Thu, 10 Sep 2026 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055329;
	bh=goj1tc3asD/oYv2pGPsO/WvXVjsO5Wp0U4vWhwwPHCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WLCpJ4rsc1VQ3c4XQWeEqX/1gKB2CGQTNfzCL2eeMFr0YeqCa4O6YOGYrvesNIxKF
	 fCvK1pxCSCO/TtmpkbyLhqBKIKHEv8OxGidJDW05IF8goQsalqoK+Ve6IU5y6cb4dw
	 RnjofgHvrAkc7frSJBLrlP+PDwutVbWz2GExttVJj0uTLy4rZaKHEPxkuhYNdDo+HM
	 xp0UTrqHj3X5iCR6yhGvm/kBapwbukzE5O70NylmR/RzquEPXONa9IeAFedzmsCKNI
	 M1v+KsHSrM2y75iO8Nsr/tBZYLEWuBaVTYYANQWiyDUMdBFapM15L04TRTXLxAvRN8
	 8IBVLDFzwuZxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:09 +0200
Subject: [PATCH RFC v4 11/18] sched: add wait_var_event_state()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-11-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QApuKVgrVB1jXgqZkVjQ7A4FioHcx+RM/yMmJ5wv3yk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumg3nf/h9FnpmYpK72fP6vR5nXVQOGPph97EGYfXl
 nA07W7W7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI726Gf3oLT9zwXyPFFve2
 gMn6e/+kSNELrqHfz51q4wsxjL9aYsDwz2CNSkan9czOAu+DIa0aWRnBzNd237O6eiL6/pEv4jl
 neAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

All wait_var_event() sleep in a fixed task state. For coredumps we need
a variant that takes the state from the caller the way
wait_event_state() does. This allows us to continue sleeping with
TASK_FREEZABLE. That's certainly also a useful addition for other places.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/wait_bit.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 553d7b23e3ad..af077ed4caf6 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -432,6 +432,32 @@ do {									\
 	__ret;								\
 })
 
+/**
+ * wait_var_event_state - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ * @state: the task state to sleep in, %TASK_UNINTERRUPTIBLE etc.
+ *
+ * Wait for a @condition to be true, only re-checking when a wake up is
+ * received for the given @var (an arbitrary kernel address which need
+ * not be directly related to the given condition, but usually is).
+ *
+ * Returns 0 if the condition became true, or %-ERESTARTSYS if a signal
+ * arrived which @state allows to interrupt.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
+#define wait_var_event_state(var, condition, state)					\
+({											\
+	int __ret = 0;									\
+	might_sleep();									\
+	if (!(condition))								\
+		__ret = ___wait_var_event(var, condition, (state), 0, 0, schedule());	\
+	__ret;										\
+})
+
 /**
  * wait_var_event_any_lock - wait for a variable to be updated under a lock
  * @var: the address of the variable being waited on

-- 
2.53.0

