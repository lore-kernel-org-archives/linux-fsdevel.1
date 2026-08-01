Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502B3769F0;
	Sat,  1 Aug 2026 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552296; cv=pass; b=BPCSD8M6wleGQlMyTWGsNcho+XjHv1+x8amP8FK1zvJXSij0BF+mX6NGslnhXcRDkKqYsA6assDXoHAFPQjmBhGCr+vcXhk1cV6s7pHDoqXMS55bjF2u5zO6o6q/YjT5qPO5Nz+PPsUFBc4DjssIhe3wfJoUVolO6A8ZJFpRCGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552296; c=relaxed/simple;
	bh=zyJPxoiOrrTncnBcq0G6JUejeu3HJUVRGlaRt39h5hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae+Iqcw3ymHEX6m1dEuJ0ZeCEaLrci6Eh6eZSYcvZJQOmd2UaiQ2a6nI2XfZCEYzT+mG+KLc4b5YfUN9IaHc0vILko++DBkTEVOgPUiw2Y4Y8h836/UYZUewKp44Upz4mQ+ChANK/kDvL0esxPzsQ4O8PDtlwe5M5usDuGz5fJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Wd2JPqoE; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Wd2JPqoE"
ARC-Seal: i=1; a=rsa-sha256; t=1785552281; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XHfZ3N7nbKkYz73F4MW0JPeIRC3BZRfV4vgr7RXBv5iKbNU/yJJT+PRWNcmH6No25/aaKLRcPDC0EotI41A/rwan3QfxsrQ9150UIHgbCkIvAZgMWB93auOxoP8Vly38UD7cWohCqncOBr0u2+HcgJWAyDFOIwQN44nlIkAJ6dI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785552281; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zyJPxoiOrrTncnBcq0G6JUejeu3HJUVRGlaRt39h5hU=; 
	b=XgSmZMFguhVWi6iJHZk3MgUXNrl+KeHluGw0BwjPqhtjGeTPOVJeOwv1vkuQ104rCoQEqbnOC7ywfVZJFle8HdBpNFQONatxDFUVpf6r66QdSTOmZ2/Gq4NzPj1CfGVuiP7R95bU2xmAi8BpSbJzfFVC6EGBUTmelAkkd7/NhxA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785552281;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zyJPxoiOrrTncnBcq0G6JUejeu3HJUVRGlaRt39h5hU=;
	b=Wd2JPqoEqV1BZy0yFUUOWotUN7A3GvwvrmChRofsOounlBKVJmMzUK1VRUirc5H0
	JcU6M+954dqqMKSoVxl5SNAW0DNcQ3Cz7ZVQ3/NH84ceS+o4ULO4YOL598DMVtukWIQ
	Ng+VVtcjCAfCuyVHOuXcc8mKlDiZQFn4fnBsaHm0=
Received: by mx.zoho.eu with SMTPS id 1785552278570961.7836499270942;
	Sat, 1 Aug 2026 04:44:38 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Sangho Lee <kudo3228@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: reject malformed cylinder summary geometry
Date: Sat,  1 Aug 2026 05:44:28 +0300
Message-ID: <20260801024428.13324-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701215700.822003-1-kudo3228@gmail.com>
References: <20260701215700.822003-1-kudo3228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

I confirmed the overflow this patch closes. ufs_read_cylinder_structures()
in fs/ufs/super.c derives blks from (s_cssize + s_fsize - 1) >> s_fshift and
then copies a full s_fsize bytes per iteration into a kmalloc(s_cssize)
buffer, so once s_fshift is inconsistent with s_fsize, or s_cssize is not a
fragment multiple, the loop writes past the allocation.

The two new checks cover both cases. Requiring s_fshift to equal
ilog2(s_fsize) keeps the shift that produces blks correct, and requiring
s_cssize to equal s_ncg times sizeof(struct ufs_csum) rounded up to a
fragment ties the buffer to the real cylinder group count and makes it a
fragment multiple, so blks times s_fsize equals s_cssize and the copy stays
in bounds. struct ufs_csum is four 32 bit fields for both ufs1 and ufs2, and
this expected size matches the fragroundup(ncg times sizeof(csum)) sizing
that newfs writes.

s_ncg, s_fshift and s_fsize are all assigned earlier in ufs_fill_super(),
before this check runs, so the validation uses initialised values.

Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
