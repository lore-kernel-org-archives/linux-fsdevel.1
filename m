Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177585;
	b=VKsIqEHKl8AbAHhZ8OjwUII8y59LDJWIHYYi1i570BsmBnpEeO41Wmz+YTnUe4usXbvL
	 2qdR5Yd546MMrG2DuZ+a1xZAna58uUEpEqfXMi+pJs55lApO+SF0RWIRlnJSfwsa7R6qV
	 KbBrVi300U+4CVoB0EBFiszeiXSaDA9ZI5hU7SdY7k1MUUfzKjxlBoJeKSevFwokJEZv0
	 M+bmvKfNeveeeiWc6mkjCM7abRPuJ15UIttUTX0xzZ91lgS/rvZGcdFud3QzrRvu+2aJj
	 UNkmTJvkje8/bcIh6Rk1vB8ChmmkufV564VWEXEx69QE/TDT6Za95ikVOw23Izlq3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
	b=uVqW5nZ21CsIRqtVJSs6C2tbJalA+5DfsyHr7m1Tjvj5gUiDMwjZE/USxrxvSZsdm5/V
	 lWmDTRL3AT2n7liRLcyhd3CcCO9xYj+bZsfwWbl5x7ebiTitGk900B7NYl5IqbTpeEzDV
	 aQC0Z55FoF001NQ06TfRPZJI4e51HsMyoETgJshcUuDC6x7RG+cs8guu3FhmN9+R/niCO
	 n36NgTTbSXyo00YQDeyfcXFb3p6jAU7YQSPg0YoyBQXUhPCsev9+z6zi/sSksjfzTO5F4
	 RTPK6veJ7hkkzHxxsuoN3blg6mNf2scAedCCn/e5cSOB7WkkwciYXg+H1T7hzljfxmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NF6P22Ua;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42373606A339
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 22:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42373606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NF6P22Ua
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso689848eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177584; x=1794782384; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=NF6P22UaPGr1HDfea9kIcWbvRKcCIqN8QEnwFDbKz7tk/YbwkvRrkeVgpGhGtL4pd4
         hfj9fQFfEsWjRGIU/+FpesE50zkmrNYtB0biAoRbXjgTG8kMFlw/AC5Ttr/5yXHV58NT
         pvVgwNyRYk/BerQZCNGYBlTcX/bdD89VaZWATi3zdy9xhnS3TijcKHBVOoyTt5heM+Ck
         cKpvfTO3CnEyaewDLme9eiHmbl56rQt1ycDdA87P+CCgihWAn4/ugTKalEaouLl+FTTk
         pJH/XwedfFvWkr1XlZ3RGbE9CRxI3L+P1FZ7lzjMyolBo8TwkVZOI96BhudO+UAAzah5
         6xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177584; x=1794782384;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=x0to5lB4tHFFXL654N4qJER8L1TU+4G+/Vaj2i7KWDCW4KbBMknew8dCjY1Qu6FCnh
         x9LmU5klv8obrusWbotvbyHwX8PW72hzxN44NTGshW6s2qcQgJzRI9xx28W6tGxBfSWa
         u0jfDOMV61nBxw4zqLsD0FZnUoRTDFoIp4dyJlcdLx6EtLAjLXJaOfDIF+S3kR2U4Rdu
         jXY3W+irHqKdRiUIDpjjQNa4phSzPMa1zY9bloU96C4MYkJ5lns+pCifDVqH6l0DVwm6
         CkTttOV3I0S0iYRGgvCOYuXaWWfUIzl8v/BR7FLqkRUMIKCEtQ9gvqYPBorBbhxZdx+M
         R/NQ==
X-Forwarded-Encrypted: i=1; AL+hErGkXpbBaV7y2osF8tyVzMIWDzDsaJMrM2JlwPhUTV8eunRts/GfhFrOPFmfMPcOMINXx3IsZQfdBcvnB/CL@vger.kernel.org
X-Gm-Message-State: APuU4Z8wcwisr1U9ohEt8cRfiIPNonbe6VC7UQ/axeqUpm5g97b3OOdY
	MQkCBpzbeq+S9W+dJsUqlhtq9muGUplVV6QKFGUq9dCULHPmjuWUYKO1sVvVcJMEALvkxy6PiOf
	F+KMdikCelw==
X-Received: from dlad1.prod.google.com ([2002:a05:701b:2201:b0:1b2:6421:f4fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea8a:b0:163:bee9:b250
 with SMTP id a92af1059eb24-1b39fedbec2mr3348910c88.22.1794177583902; Sun, 08
 Nov 2026 14:39:43 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:06 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-3-irogers@google.com>
Subject: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog

