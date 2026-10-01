Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB56489FA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890700; cv=none; b=JaFMH+j5XTvDhhR5lPow/GvTvrdhvNpf95k7qNkcu1UxTI54SGDcTCTwRohC3j5O24SQbQPjXSHHj9Qoj6RHgEA0WRynmMmTBHTrfhNCrCS3H1C2Lu4MiJpJGB43xDBqJybTxRwKJnBnsZE9K44rvLfyWW5GUo3lEVsDQ45HrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890700; c=relaxed/simple;
	bh=AspwvTERhCa/5SyVWGjRHHTsaV7FE1ndt+3lzpHQ+go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eraW0SH5IdH0qz9zoIuLMt7TvTZO5hKQuwYneeLj2e2G9BLkwImc7vQqY4NJ1wtnAf3yZ+uNmN5njAvmgPtKg0q/x214y99D+4561WvEed227wHnkHHJqgdLAwP1e5UyiPLUTo86mT/kbs4xogZkSAD6NhUwDFmKB8zcCH5tftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=nF7zpyng; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="nF7zpyng"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba330dbd67so2984954e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790890697; x=1791495497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgjFQHRzOc9aDDIMHQL4Oa7S8OApJyx2CogFTCRqEAQ=;
        b=nF7zpyngmFd+ML31Nt78Io2+erTKGxVvwUEsqy/qsGN5RbaoeekdN6iBOZ5jOKUCGd
         qwBvJTriOKOtyVfxAYZxpNAKG4n4+sxk+q/JVqW2JaT8dRcCtJkBK9vBuDxkWI401q8h
         zySFMnjJuzda+xXxbDpMpjFpv1RsZHZ2/aJ/otWbD11HEm8iIb+t3pT6nIj2V3C25b9E
         LsdyJeckYi2KJmixtsJmXe/UQBnknn5mTjiLFMqnc7bQhY6xZIWUFlAkyXwcFCvLP/M6
         bXVSBE9Niq6YnI+6NH89cKW9jFJgGqkKYKbZZ3Etty5wwMNAx5482xltZg9EoH/BsstD
         pX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890697; x=1791495497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fgjFQHRzOc9aDDIMHQL4Oa7S8OApJyx2CogFTCRqEAQ=;
        b=dh/qSY5ZfxU6SXKQgf4/xG8ncqwaXElh0xezoADZVHURvEsRzhjN7WnX1s8JGfZ9si
         Gf6AKqsYv3rZU05e1itO4HkgSt+ImmZ62Yp6lNxI8D8Ppnbc8phMh9KSwrkGnDkiwSij
         yESnFLLkQg70JgWDgn3T1VQmATep7c72aNUSquK1Fk4mO0BUECsT0Nk0RnjAMrMHUcBm
         phn9cpdAa2NwnYUKh8OBFmzMKKSAegsB+W4x9Fd8zZu+e8qn3Zmo00uiTeI/ujvnj5Xq
         tIu7NK8tJG6qS66pkPQXBom9iapkr/WGLCPuXVdbwVuXxJETkU4y0J6rHWL8MePGeSSS
         gu1w==
X-Gm-Message-State: AFq9FYKRCSLIHzgMB5QFi/cWcSo5CH9ittnJUMsbll22FLRXasY5n2q/
	6YuuLMix6MdqVZY1JwTJgVhJ1/Vj9ciHRY7yPdbT4LI5ttcEZgmxzT3vJY3P2BKJ+yFs7LaM+sl
	tr/WilK/wiyx5Mg==
X-Gm-Gg: AYBFou2xFHvUei1in8ezEPMiitwgItow298mkRFeJJ51VVWw5j4YP2xBY1+y85c3ux4
	DqRPUnAU0AJ72pZUFw3QIpZx+iG4kTD6SobJL5tFiRJ6bObI3jDARbNZdi9xYSr5DJaGj3wEaNc
	Z2cqWX/U9AggAtRDUQ7epLC0QfdOhfmW6SujgsFkp96b3QTiVlvguJeQ4BkKW6W0uvvvXIcDYy3
	FD84cfRQWxRbC8DN74Kf1am3NmjHI73T9qHqgwX1CFRzMab8yctXsYssai10tMWtyRVtEN8tOFv
	GibVqAWWHLoDvuP+dWqOM2IL5UjHEGYWW2uWRG6rnchHHssnIoODBwY0AhOQUFEKIlMK3/R1L38
	WKFeRdbJACji2iqCseQivQDzPTg8rKnf6oGupVv2sy411QSd8jRKfqVEjaoICRJ3JPsnqwR9j/A
	MyOcUc0DonqV0D2GZLtIeNw7sK9UtNj6pV5DzjRWXIlD82l3yPfDsAJDVWyQdv1SSGYS6BOWCOp
	GdnVl4KRLjk
X-Received: by 2002:a05:6512:8345:b0:5b8:b2f0:b5b0 with SMTP id 2adb3069b0e04-5bb9bb260e8mr124544e87.46.1790890695967;
        Thu, 01 Oct 2026 14:38:15 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e333cf3sm2294361fa.39.2026.10.01.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 14:38:15 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH v3 0/2] hfsplus, hfs: fix B-tree node leak on hfs_btree_open() error path
Date: Thu,  1 Oct 2026 23:38:05 +0200
Message-ID: <20261001213807.1519745-1-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0de056179e3e0a7c4ef525cdb143647b7493dc71.camel@dubeyko.com>
References: <0de056179e3e0a7c4ef525cdb143647b7493dc71.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the hfsplus/hfs B-tree node leak fix, rebased onto the
for-next branch of the HFS/HFS+ tree as requested.

The leak is unchanged: hfs_btree_open() can fail after the head node has
been inserted into tree->node_hash, and the error path does a bare
kfree(tree) without freeing the hashed nodes. The fix factors the
node-hash freeing out of hfs_btree_close() into hfs_bnode_hash_free() and
calls it from both hfs_btree_close() and the hfs_btree_open() error path.

Changes since v2:
 - rebased on for-next; the extracted helper now wraps the hash_lock
   serialized close loop introduced by commit dce0e0248205 ("hfs/hfsplus:
   serialize B-tree close against folio release") (Slava Dubeyko)
 - on the open error path the tree is not published yet, so the lock is
   uncontended but kept for consistency
 - no functional change to the leak fix itself

v2: https://lore.kernel.org/linux-fsdevel/20260930232312.1405042-1-guvenlik@noroxi.com

Mahmut Emin Kurhan (2):
  hfsplus: free cached B-tree nodes on hfs_btree_open() error path
  hfs: free cached B-tree nodes on hfs_btree_open() error path

 fs/hfs/btree.c     | 40 +++++++++++++++++++++++-----------------
 fs/hfsplus/btree.c | 41 +++++++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 35 deletions(-)

-- 
2.43.0

