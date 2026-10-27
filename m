Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140768;
	b=OyFTPax0tLFR5R9r4FlLTe1u3CZMSKkv8h7dDgPAyW4GfYJjDXiNhTTorEnNAxohiioH
	 cezXYk9fO41+k3q1B2OZNMJKVOJqpEM/u3TupQKgG4wgPQeCbV6bd9VURMlfLqU5c8Rt1
	 JY5reLt0SWAOzJbC+UZv4etXSvoWRedB+bpVIN4uiJKgmLlovIWBbffaVUMbMXLmJbkwE
	 FSyBkSGqWoFfi6wwKofLy7FGeDwy3tRu+RUKtLUItpvGQ6G3h6CuYHuTp+mSGOVWSmVuB
	 DSiyBn+u5VfYrjgJVdMbWDae98vv03w0BedYZJNBEIPTBzs5XybWcWhM/xjS7IM9VlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
	b=buJ5QFuEbmHwgt/ZisRQwgykvFz1HPOuV2eVa+UROzvUukv4YXECpKf6MWW13ZTq65ku
	 XeqqnfXm7oYicivyb8sjpAvXkthi7pEzJcE8ZrY0DkG4nf67xEStvx2h86nYdm+t4fD5r
	 +xivO3+mSMCcLj+8y43RaTO/dAugKPHh1wknXwA7aadzc8W1F0ulsNnBBlwbJdnN5lOu9
	 9LYXha5EcYouhdwgf9lJzB3AsAhi7jJumBX0ZMaFcgPuFldgw6gl65gtcCp1CkxyxNxdy
	 hq0EdnII+o747hjL+tFlFO/CwxwzlpPmsAGFfcZLat0cS+uJQExDdd4bJ3mdFIO/HWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A860A3832
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64A860A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so1025592c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140767; x=1793745567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=liNe3HMy55X9pJAx3yYfGsMeNT+e1JnZxB+AQx3A5J9VPGgN92YzVbYvd/za/Drr5k
         lst0PfcfRGocLlrgPC5UssnxEJctFzU+pQm+95FdUho7XQl8tD1ulM7rKwt/jNE+21Vf
         Z9LeRG62rYmnsPQmmg4JlXmw8+AffIjWCQze/e0A/NrbyHM8TP8o1608vrQLYJKc1eVF
         dF+siAZRQfjXJUi0LYKhvOuPmzmxcjf9I8fjPgny0U321qhAu1Pmw+Bv//U3MdnFtahJ
         7n34bb7IiC2Le1ntE29Feez7T+/eMXs0L62grlkW9U2pgTYjfEQQlg6qoj1bz6MQC6fW
         lCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140767; x=1793745567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=Ctz9uJY8aN75UTTo4Wy1RHB3cZhrh6L7MxG1Abv9rfAxAlrFQq9v4sHUGwU/K/mCiw
         6rqpcKBYk3ksbQPH++JHkINAJzx5az2sdrt8/t/FZ8B8WtCVn9Rn+xva6Va9CyF8akkO
         6MP/R6+7UYlUSQIS6Y7RDI0l5P7C8lk49LiKVtcFg7OxUGKWjuS7/WK4R1zXQJK5sd/W
         uZ/e0+3K5DY++rGbolhMgcmP5fV7XThnavJKuAwMBvmgd86Hy6EXPPyBstGwpMk/9AL/
         XeDH2Bgu8jX0cjXWNggy1YV1IAkvnJzQ6KfTjKPNhTXWxHycKzJrzj4NOGIyqpMjSWeR
         2f6A==
X-Forwarded-Encrypted: i=1; AKwUvByBFjBcY9CeXoOYPw+iXqYuhSv7ztFy3nHJmhDzWzo/2hsDb6MdcWkF7TDiqvImhXHvkLzWjrq4TMn0A0hS@vger.kernel.org
X-Gm-Message-State: AFq9FYLUGJGv8p965thNDs2OMUUUm6RDGv0UDxugA2cgrVAswOKoBEu/
	bNLnGofZHY3LWl4ouPCdJhfSkiNfV0XxclirgtLyfNcEXZehi5dVGpn94UJq3Z81Dm/Nmk46cJi
	8jOyvPhB6Lg==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:1a0:a0b4:204c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f115:b0:1a3:6040:bf78
 with SMTP id a92af1059eb24-1a6cc34d07bmr917417c88.11.1793140766453; Tue, 27
 Oct 2026 15:39:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:41 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-7-irogers@google.com>
Subject: [PATCH v2 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Content-Type: text/plain; charset="UTF-8"

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.0.313.g2479322e68-goog

