Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB6283FE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479490; cv=none; b=u0ZY/6ify+Z7lVvK2qD++Jq4ghtU2meDRIlkJ/EeEq75mGt6F2C1wjYcQ/GCDUegeEIts+6+pgY3ZD7LvAjDCmCGexyDLFTeW23WtpCYGMwIWmESCSC5R1rSGiHDLLQxsXj1uPkulv983j40tbKiLoUXPGrwxJuogJAgT0KctrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479490; c=relaxed/simple;
	bh=lJ+OBwpSmNxu05yOr9PmGJPJWDTMt0GEFw3mqTdUhs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXYzCCwh292lsCG9mRZp+3UFf+p+km/y0Ks9fSWb7JCc4c+5Z23O/xClWccXp2QNjeaUBxphFsAphGkRKCOAJ54Br1sYK4xICfA2Jw8pEZ2UXUKX7WWRM6mqKB/0/SeDwTOLXM7ajMB0bVWogJMuBPylIpuQTRSB2dWHaa5yJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km482adA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km482adA"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845b88dc991so413194b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479489; x=1783084289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjcfW/YArfhSkjN/lzs+Iq6KU+eSjbr3oJOOoEG0Y+s=;
        b=Km482adAphl9XixZybzVwwbi4VEZkJdHvv2vZPMZkp2UKL5JEbdig3py55DYJqwZt4
         jMVO5wQME256Hu+sFs7Mrz7vETVV8ael9+yXvCugU4A6Bk6v9WCB/hRsdmo1EmYaDt8w
         waBmGAMzRf3cSviRC5Y1z52Wlbpb2IvwxE1HWI20f+NInaSqXuHFrPNv4ILQ793UW86T
         bQZ3dwa+uE1D8alaO269id6nCSe4VKkn2AiM3eaCYrND7lJfhAystACrLhgMHUyNAXZC
         xaByC3e3QxugCK5wzLwgfriSh5mk7g9Mg84fZMdpd+mHJQybr3sJhmFwKB6cOMzpVqrp
         QSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479489; x=1783084289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KjcfW/YArfhSkjN/lzs+Iq6KU+eSjbr3oJOOoEG0Y+s=;
        b=lfynkmVJLZ48h9rFpxN5Ilg4u6MJQB+NNI6GkihH47MJCjWPOxBbqS4mFMRX56diaj
         fQdQ7o9JqWEi3bjCH7uGkDshY4cihb9gIjDl18aCYIcUX0EOQbBdGo1E2lOzQDx5+Oha
         sZgJ8QmQQVxV2bjGJXNAtcTe+yixWA9zxZgD8qzjfZV6/w+i1/wiDloOM228Fipa370Q
         lzU+dC9B14/nEIe2CV3RTSByXz5hJ9QvRur4JtYwysJA4EAuGwms+j73Bn71GrE6VYK5
         AndbXScSDHR7qvhIB5PkE59duwFBvsrvRVH0RK/nu5I6hE2+CDbsGpcbEYWl9Fgvgp1u
         amYg==
X-Forwarded-Encrypted: i=1; AFNElJ9jaYvbeyM2I6f/d/Svgb3z5opbEROeSKDAcxzcYrV4jxNeu7VzeEKEv/iFy1pt1yAFihluzZ2/absSxa9a@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNBz9w7FjpHq6aLpS3VWKMOxGkNJ/TKqtQkN84NzSNa0k8Djh
	4MpPZLNhDJ06nOghFM0rGs7Iht56feJu62ujabih6BNnwSA7B2NBrYZw
X-Gm-Gg: AfdE7cn9uFTMVYmR64sEmALTID4k9ihvXNHYb5ysjXlrLDPdhB8oahbwUF+33oRU7YK
	ca6udX6Fy8Ks0u3K1l1FhsxekQDXIw7CHblzVNyn+b++eWj3jf4Pfgzaup/6uETAqKywXG5jkHM
	WQDJHGiHQdnTimusyZDCKWoQ5Ub81iecZFid3XYANoni2sdnotFHLpbZzsQ8GmbuqnumNkBfuBp
	Ia+0ARARXMp41Pi6X7p5F5ugBQvPCBCAISWAn1Ld1aYZPc7OwKzrwfKWeCKf+O0gDiaeBSkkzUO
	9IYRzUv1PFDfirUL3bTg576UdIj2p7VOWloGgzWrXGHFx5MPml5FSRofnxSBD2vx+kEx6kjQKj4
	EN7eY6ToC5unzE53xpbQY3V2x1076VT3xs5+yxh9XnGXSUOCHDs7dsXMF3MD+6fzcXvv/QCNn9G
	DOnEVJJ/YDkWfUtzQjoqqmleJAkI9KCFGwPu8IjnRUF2cZNSM6kUIHCna7zKg4GG1Ud9n+dBnD
X-Received: by 2002:a05:6a00:22d4:b0:845:4679:4a3 with SMTP id d2e1a72fcca58-845b3aed31emr7700824b3a.19.1782479488475;
        Fri, 26 Jun 2026 06:11:28 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d234esm7104461b3a.29.2026.06.26.06.11.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 06:11:28 -0700 (PDT)
From: hewei-gikaku <skyexpoc@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Xiang Mei <xmei5@asu.edu>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: fix out-of-bounds write in ni_create_attr_list()
Date: Fri, 26 Jun 2026 22:11:22 +0900
Message-ID: <20260626131122.1341-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624053008.4885-2-xmei5@asu.edu>
References: <20260624053008.4885-2-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Weiming, Xiang,

I posted a fix for this exact ni_create_attr_list() out-of-bounds write
two weeks before this patch, to the same list and CC'ing the same
maintainer:

  v1 (2026-06-10): https://lore.kernel.org/all/20260610002929.51765-1-skyexpoc@gmail.com/
  v2 (2026-06-25): https://lore.kernel.org/all/20260625031932.9412-1-skyexpoc@gmail.com/

Same root cause, same Fixes: tag.  The two patches differ in how they fix
it, and the difference matters:

  - This patch keeps the fixed al_aligned(record_size) buffer and returns
    -EINVAL as soon as an entry would cross the buffer end.  Because each
    ATTR_LIST_ENTRY (le_size(0) = 0x20) is larger than the minimum resident
    attribute it represents (SIZEOF_RESIDENT = 0x18), the list can grow past
    a single record_size for a sufficiently full base record, so this can
    fail a normal setxattr/file operation with -EINVAL instead of handling
    it.

  - My v2 computes the exact list size from the attributes first and
    allocates accordingly, closing the overflow without introducing that
    regression.

Given the earlier posting and that v2 fixes the bug without rejecting
otherwise-valid records, I'd suggest taking v2.  I'm happy to rebase it or
adjust to whatever Konstantin prefers.

Thanks,
HE WEI
