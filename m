Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322233B6C01
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223070; cv=none; b=E1XDm06n+35wvjMFdZxxpCQ3HaY1ofVuyKd7sl72miRwIfQ7yI+z0lTiPAHl1K3aOdFkfyY0j5rCTjjvlkwzYOrgcDExTWsA2uxYEJw9tXaGARfFoiqLzVL0M8FrpnFC2eWrpjLhVLzF+QPTh2E/pLNZEZNKWHfcVmTeJ7Z9FiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223070; c=relaxed/simple;
	bh=QTMXuMhWH0Xv53pMrhqo3TWHZJnoVQRRVF9xlJKTYL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsJLLojLLf/xaO6/BBKCjbcDyKhL9WCvZZ7J7ZW9LL7wZf5jLkMI1ylycWQrx7CF2+TP9hxbB4E9BYkcWNU7WN0YCOrYAUQUXb0F+9ylja3KrUgN5WELT5mlLVsrR9d1vNNT32PKs20JVMxEzfWEGruci5a+xJbl67pJ4LYh+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5cIHHfe; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5cIHHfe"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8296d553142so3678358b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223069; x=1773827869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOemOY3GRBon+h/gNtOxQ4VEEGmdm3FWxbjJem+FfZM=;
        b=Y5cIHHfeN1BtQRGURItZG2EBlaLOBDCXpZzV23/iWmeNSbtlzmL8JJftkCEuqnmnck
         0JAjXzg14VV6bI+v7tOy+sb6VKitlptBAiKqSrhBhePra27hU46oAjG8Q8DSeSckSlJb
         EbZcBQjCFNEUoMlFYFJ3+MeGq6o0UfcyjWMDM4BVxF6xpDvK33B2Y++tPsK374BVPRbR
         Dhz1Cf4DnVzsvGCO1hfuAKwAgaYgLI+z/mUdVCnjLIepycAgG0kLAXr+Q5ep1JusQoko
         7N9QZiFLMmBhXb9xbZRsisbSsFeCs5W3KHn3au4OoSGwSZdjkpM37AZU8iXPplerB4En
         EwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223069; x=1773827869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOemOY3GRBon+h/gNtOxQ4VEEGmdm3FWxbjJem+FfZM=;
        b=LkPJrRdi+VNtOcgLVf2cosjHAMS3UD4DBSkXAKF2tXx80mbgnznGCoAlX/1SR9Jn6I
         EXLU/1C4zpputtBMFAPE4v/3c3Fyk5+X1q5c8yiOEImp1OGyA/hGMih4VTB1LQtXMVSS
         L1UXXQF1JS1PDGgF+F5oAXII+D0r4dXZfh1qbqqk8BHey7YYz/otOns0oq4wBndXr057
         +faV8fhgmi9xgP37qN0nocP7ieFgO4vxbse+1BQjlUXEMi8ItEBjdCGlWZGJE6zuM6+u
         nv2IGe2mNLow54Y1WmW1DT0PxuyEUB/1JlBsnB3i1yIO7hg9LGWeBN9zL0NrpyYBSF7w
         7H1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4t7ESB5J//hACtG8apllWiyqiFnOB44HVo9V5/ESTAzbMXr/RDc8tNOioeDeIXct+mmn0AUP30ojd8utF@vger.kernel.org
X-Gm-Message-State: AOJu0YxOW3bzGcsTb9XB7iExm2os++GIhTm1PCWEO8sha7dLDieH9cYW
	MCpU5UbFI324pFjOpw7/rSnZJpCsGNRSkd6hyn4RN1vVmYgK1S5DX2Wz
X-Gm-Gg: ATEYQzxSQTm72YtrDavWW1qCQrZrqjNNwH/zjeo8HpbK7XkvpZRrojAksPLr8yXSm8m
	6utzg/iJKvnjkhBg8KGMlsLxsnS/rwrL+2/m/64TCAH1yXOs5P3k9Sc0wTU4GQ8iSwJXt7Z/EMH
	IkICYklpe3O+Nuo1awCE0nvh+1bQ/Nk/kR0XluUysceUUgMaFGgCYIf6dW1/mP4IEP8oyJQhsXc
	FrZYWbirFxbNSlw9up8ih01gJKyHdnM8pJne3ncKW30FhmIACw72A8pNvsPgOd+wozajWOCPZcQ
	gXnWYN1q82luTPGBg/Q85uttSgFc6fwyHoLtFKsRf5kMhy2p+8HvQj7YgicDTNmrofHC3OrwWNB
	DXqsauhnajYwLa5f37zKRbkAqs+/6LwXwYmIXl0aNMKLkSQjAnaeHsszW+36BtK0qJy3yB3YGGo
	lgX/wd0diotw9CibKDMrXh+3B9EiXr1Sqc6Atcw9OOzPhHqtI0Xid0ZwFfN+MB
X-Received: by 2002:a05:6a00:1304:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-829f7094b3bmr1933452b3a.23.1773223068600;
        Wed, 11 Mar 2026 02:57:48 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc83cfsm1799712b3a.7.2026.03.11.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:57:48 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	chao@kernel.org,
	jaegeuk@kernel.org,
	jannh@google.com,
	linkinjeon@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	pfalcato@suse.de,
	sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Date: Wed, 11 Mar 2026 17:57:38 +0800
Message-Id: <20260311095738.4177239-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/slub.c b/mm/slub.c
index cdc1e652ec52..f029003e7368 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2629,6 +2629,7 @@ static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
 
 static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
 {
+	WARN_ON(sheaf->size > 0);
 	kfree(sheaf);
 
 	stat(s, SHEAF_FREE);
@@ -2660,6 +2661,7 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
 	return 0;
 }
 
+static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf);
 
 static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 {
@@ -2669,6 +2671,7 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 		return NULL;
 
 	if (refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC)) {
+		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
 		return NULL;
 	}
@@ -5027,6 +5030,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 			 * we must be very low on memory so don't bother
 			 * with the barn
 			 */
+			sheaf_flush_unused(s, empty);
 			free_empty_sheaf(s, empty);
 		}
 	} else {
