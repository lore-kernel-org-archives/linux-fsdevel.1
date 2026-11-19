Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116373;
	b=3mo5HLTgkfgvbc6g7F4WzOfy5wYlIXtbDRSNiQfGyUOACnUO9WyzwEhrEl7UoRkfFVTo
	 o7UGCT+QOdK7NWuBlq9mTB30lAyu6qM7TJ9vMl/eMGCJ/SZSmRWxFczUoI2yGNLloSDBb
	 XWpXHRNdZflejjm95EUAi+mZJxhlq5qgpCGdqq4aCdExCcqWVaGFvC4Hb+GSDF4qE3SNM
	 kkXW+BbyeI9GvTYw3H7P/TxMHTWhuFgFakvkpJBnkmV5DkbeNwIzuHxE3lulp0YQ92GvR
	 Tefur42O4GhqlFmiR35bW6zfK6P2lsRWKvazCIUaOHAfVIchlxSxko+vklzfC1vHaUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
	b=qSyBRCchT7vAqKT14mPZrgdhnsy6RztlJIqpArcyBzrAow0U+mr2wb3xu3R2c0f/4rzl
	 WA/lZpA0uh7zHFZYeK0kinAVfb239FQrx5TR4O/HBufn27+WTSO7WkBjFcQxrOqRePTmU
	 aHoqo47exW+G/eU2/T9TLlRr0cNV02nmEj3xQgMW9EP5851wZW+ZqEHQx/nr3jslv3I+H
	 3QMbliSzggTzEn3R0kuwt1W/Y9xMDUC+31tpcqZavVAG07Dt9sYEPSOhtZAKGi2Pz2KxP
	 IZ7korUi2vTDejt9iyhcAK2IEAiV38+duXU6PpMDayZ+QNr5/zz18X9KlZshi3KM6Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kLKVMsB9;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908260A261F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3908260A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kLKVMsB9
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383f2d05c73so196806eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116371; x=1795721171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=kLKVMsB9YDaG4K9j6iMehsycwJx0ij9U+zmFqOnRmYHu53t6nEiX3t8yU3HxVvB+b/
         6KyiT8DM3Qe/mOTjAtQojTdUiR3Z33rCCdl8HCeQIoVhmg5xeCyf1uUTKPgTB08m9y0W
         wh7Bmx0trBkjDpJikZ7sItLvMM5zb51kE7X5w2jxhGQpoWhxk7dPMrKtTAtkRESJSasl
         VT8nSjUna2MpBdK/el90bXgng+kJf0I/4O9/UiUly1YL2wWCJzd+BxjmU8W+0PGukBpd
         UFdMDTd7qYZhFtxn421uPMqlzEIuGiHyOF7/dHCv+cPKTMuu4RJNDBg/PJiY61zY2WF4
         7jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116371; x=1795721171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=WkDn03DgpjCWlRYN7euu/JMGBGd/wtJiF6ZFGX1XndRqY28X46+UBpWD1UTQBMhQAC
         ++Mtw9KYzF0rlCkN3IWJOOCdsZX27RQYKG30AbCg1kpjs3WIzMJdm9novh8L0+Ufemsq
         Twn3kXG0LJpQ4xnV0wU3B+fiiTLaIPR5LIffL3jU0B1opR9aT7W3kWZwC3CtWuidF+rZ
         jabmvDIor2G8llASimPONxWBFYzSJGeXlK+wNqJDkFNiO2YDh75JwN17awqcuvMLPJXA
         f6JVFEjox1gthxspV0WC1TifyFJSgGjcf0OQXDucH6IUkMyeY4afd+6i5dwj8oFmhshP
         D9HA==
X-Forwarded-Encrypted: i=1; AL+hErFHN5g9L4qrbYWO4KvmUXo2RNxUlbKAO+u9U4G8jdXTyHk5DmGcoCe4Af5mUqnq330jKPDAw+p5NzRCdAbs@vger.kernel.org
X-Gm-Message-State: APuU4Z9oyeIACqQ1N2B3VLjuN5SQZp7NGwAImY7XOTI3a5xzqY+lWUZE
	gdg4mIU3XPVgT09S/ZkvjG38Qunp5QNp4Nt9n5dQsg+s4PfiHzlbcwJUnCHHTruFpKGrLqU7mkH
	utCSObtsidA==
X-Received: from dyhd22.prod.google.com ([2002:a05:7300:8296:b0:381:d3ca:9f05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6018:b0:381:9593:9984
 with SMTP id 5a478bee46e88-3857151d6abmr284926eec.37.1795116370935; Thu, 19
 Nov 2026 11:26:10 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:19 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-9-irogers@google.com>
Subject: [PATCH v4 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
sysfs creation previously failed.

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6663718fb83c..b349e0d8d47b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -512,7 +512,15 @@ static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
+static void kfd_procfs_queue_release(struct kobject *kobj)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	kfree(q);
+}
+
 static const struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_queue_release,
 	.sysfs_ops = &procfs_queue_ops,
 	.default_groups = procfs_queue_groups,
 };
@@ -552,7 +560,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -697,11 +704,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q || !q->process->kobj)
+	if (!q || !q->process || !q->process->kobj || !q->kobj.state_in_sysfs)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index cd41b10e0873..636cc894223d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
-	kfree(q);
+	if (q && q->kobj.state_initialized)
+		kobject_put(&q->kobj);
+	else
+		kfree(q);
 }
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
-- 
2.56.1.708.g77570a6a1d-goog

