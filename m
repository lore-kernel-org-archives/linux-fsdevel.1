Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0D3DD523
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314341; cv=none; b=VrYdMXyRLfAjw3jsJwhTIOGpeYRrIyU0k/wvZjtkS28GTmNlyYNId/xPh2f+PrmU7gpS4jWZZ8YuQbF7fbBwtashuWEyh7EHpBas9k2CnAS/ZpgpxcFL/Ye2/GZiYBgtS9YrrWeHfFdP1GFY16FdnwXAnkyiwQVkMqk4nXSmeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314341; c=relaxed/simple;
	bh=OA6Puq8GEsEgmszu2sBjmctnxLzOG12itnYfXkTQdZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKvvDtxed3G8YT45uB9Gs+UdbsqTGb8+uOyEnnpvZ+EHAaNJAuIy+IRXHWoTaru6qacjmLiLj3Rl1vkdLtZiVFkZjHgR0avI8/9YVkSR/mYIDamDGjbk0gFYzjWGusCLMavNrpvW0ABtw7OB1eqsERYNH7K0UGo/KpzQNtpKlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com; spf=pass smtp.mailfrom=modal.com; dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b=JLHsXPRh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b="JLHsXPRh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso323070a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=modal.com; s=google; t=1790314339; x=1790919139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ehv35jM2xSxwjjV6xaS7dv57/W9hK0TedPz2NPct384=;
        b=JLHsXPRhRUDzpWZQ33K+O85NAnnMuj4hj9xhQPmP20pFllbTQBsI4gRnfQrQfkx0C0
         uCJyPpOkBQxCy2/h2sdrr7Zbkr/oJezByooYjSzid5ICG792Qm3vUcBTj62e5spaiD0D
         0M5UtHRkzdoEzbw8i6pl06zlrryg8FLoJCkGyMNTO4VQp8WzVEUNbub56iju+90/5dH1
         JFzSvejDjAd8BtbfVoHY7u/Oag0n5+wh6HIkFypeU5Sg3xRH28nKckc/cW5C+xTGsnRK
         1v/Ry6UUbV20sVPo9nm0klvBxmu5vbsqY05boRfZrcpvRGBRnbXR/GWTMBlpi5ahShhc
         aSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790314339; x=1790919139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ehv35jM2xSxwjjV6xaS7dv57/W9hK0TedPz2NPct384=;
        b=0fv4H2tCDly3OFRIX22QqTgTI4oEojAPaDbEsGth6Sk2o/sRIJrxF3CZx41nDfN/jD
         8ouJclUpWoQITDu34lTBkiVF2vEpHBbs1fqLylCZsE60fxbmjJLu5be0AMmGTJb90BWe
         1nqlq7XhdoYrojY608ynIALVqZMKnL3ci6bnghDKEK1e1zJ2Pl1iaHbmPOwupBT/yS0U
         3a6TcVqOQB+HSy7Rfeo738VeTdaHuk1oh3yJx29aZ4lKiStKGnqTW/ndBZZPQhZEoYQQ
         t8Tu6MwwNaNV8rmXiErRzsNg4WdOYRpXsQvrGAbA4rII/qY8Dnd2fBs8JNVqrWZ2knRR
         7CUA==
X-Forwarded-Encrypted: i=1; AKwUvBwibd/Wv6Er9VX1f/2FuwIgMTe2geEV5DEXpyD8JpJIvblxLUS3aqJVNSfcHpiPQQhtlg8tZ7ZEhZzcNqrh@vger.kernel.org
X-Gm-Message-State: AFuF++mUD8JJE56Ivr8qcukI/QOh9+a7l0ml85Y8GxE1W+pTNe7niq9I
	0lFLpzfP7uRvTA1L5NpCQDZE0i+5EBfk4tcA769Amh4RB3uBSo6LWotC6zAUcQgcS88=
X-Gm-Gg: AYBFou3XVoPdd2YHfYxycZ9mOPEqqLQzwtrYrTcRDd4nW+32OLFQucr6ZE2CWsws7Lp
	ox5aZerIumdTfrruVSB6JYVOogc54UBC+6lPIBi+Z0ehkPcr/1RRpm1RdxDoSPBhYMKhMpX2JPA
	iHPEBbykaVeAHrjaCx1+2TPOjqPBzkHk+9UjJz4pfC7MCpme9lUhkQisHUDqmNzcKEWxuf0MI5d
	IbgspDx2i+1aD2b/OxFbfEziu5UqpQptmfqqP+UfllKGyesEFkeoD8niqkDCj8x3/dgE/da+Sq0
	JQ/w2w+Edp38DO0YVdjNDm1Ijq67DI6INKA3r666mf6TGnhVP8hCWfznSKvLXgmtaqYV/8wbMbu
	hApsJiqzGtfY4YvrUTItrnx/UOULRzbmIHu1oidsU32CSnqQIQ7caSQqYhqY+95AJiYQ/PZ7Wlf
	BaeulLVea8EvEq5IoPBMoQLjRGMhl7TgcSB7HimFc5xbXLXamoEVKp/jE9d9zLq8j3S7gdringh
	rtRSNK66AL4HobR0FtsuAUyJAvWdiodm4n2ALA9Uxl3jjQdKtH3xgKJO3UHbZ71P7VPSq2x5aqS
	88GsYWX+txCos/udSHEHp8b7QFQqgalzk22Qd1tn66xfPn4C
X-Received: by 2002:a17:90b:2fc4:b0:39e:6c6a:4b64 with SMTP id 98e67ed59e1d1-3a098dfb087mr4009593a91.46.1790314339197;
        Thu, 24 Sep 2026 22:32:19 -0700 (PDT)
Received: from devbox-ayushr-01ed.tail5292b.ts.net (ec2-44-242-192-44.us-west-2.compute.amazonaws.com. [44.242.192.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f5b1aasm936305a91.1.2026.09.24.22.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 22:32:18 -0700 (PDT)
From: Ayush Ranjan <ayushr@modal.com>
To: Jan Kara <jack@suse.cz>
Cc: Ayush Ranjan <ayushr@modal.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts page cache / rss counters
Date: Fri, 25 Sep 2026 05:32:10 +0000
Message-ID: <20260925053211.2036445-1-ayushr@modal.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <uf7lys6izqrxjsp3tstqxmdok5yy3w52d3bnpkfzyjm7uiyqzr@ickbg3ocvcji>
References: <20260924061708.1645968-1-ayushr@modal.com> <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net> <uf7lys6izqrxjsp3tstqxmdok5yy3w52d3bnpkfzyjm7uiyqzr@ickbg3ocvcji>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 24, 2026 at 09:15 +0000, Jan Kara wrote:
> Can this be perhaps somehow related to the fixes in partial large folio
> truncation Zhang Yi is working on, possibly even the tmpfs bug in handling
> of folio split I've found [1]? It seems large folios are used here so that
> matches, I just don't immediately see how those bugs would lead to the
> errors reported here...

That would fit what I see, for what it's worth:

  - the rss-counter imbalance from the reproducer is always exactly
    one PMD-order folio (+/-512), which looks more like large-folio
    split/accounting going wrong than lost or extra PTEs;

  - the reproducer's punching thread deliberately mixes unaligned
    sub-PMD ranges, so partial truncation of large folios is exercised
    constantly, and the production "still mapped when deleted" splat
    is reported from truncate_inode_partial_folio() (full stack in my
    reply to Pedro).

Thanks,
Ayush
