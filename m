Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A201524B16
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761439; cv=none; b=VXpdF+EeXh0DHEzrUCqB5WZtCMq+/30uhvcqB6mVhXRFcEClMq9ZfZ3h8I5v6F2wFWAJzPCKG1eZ7njdKgMWQGhzvfrQNmnXKfsDT8X06jG4FyzKApIpD03q34knNf8iv5z6YUrOhOscG2P17+YRuhXyGX886Cb/5If2FPYmsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761439; c=relaxed/simple;
	bh=np9muAi3nItJBcZ41MaRS7AYDVM2KFbjwx7G+qSKc+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxmB3cyLGp9DTKl9wK+ONiufIITX0vogh9kgKz+EZvbX5nX6HTjnXQwePoePR/09u/W1QCetc6VDI/P8qTFPPIry6hUuJfOlUHdv9QKEqeA1eGSqqbw84MQsGrm+6nmo5Nvre20F4bUeRzkZ+5H3apxmhV4Pi2FwgR+DQdXZ3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=0NpJa4kO; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="0NpJa4kO"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab1ba47so577023d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789761424; x=1790366224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AblBF8irhZVYxdxm6OeuwrC2vekLBYU6NQtXHcppSbM=;
        b=0NpJa4kOndnIiFjjKpcNsV7cykH71fbbRc+rO/rTR02rJlEg6lBRLH8jy88twHHymm
         vKNRb9kRH9aJApIs/OtqiOnYP4xPVnscxm/A5ezqk5h3oahPn0R+Vnt7xPaI3RFQysXk
         qgvaeQ8sBYJdxKeM++cRwV5EZ/Tk+dMASw9CpThfvMotLjYyhslbvyvbDtdz34Z2IiAZ
         BH9JQHNyaVvZqPnnDN9EKKtgiqSjf7lQwhMFv9x7/qBwO4zGG5lDU5WQ2xuDrt9UdP9U
         rHgX/mr3DJHC/Cil7Rj0pWZWHNrL8D4wr93vgx8EYYu19GOT7sdcl7AuL/v8mCPkg6mv
         GI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789761424; x=1790366224;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AblBF8irhZVYxdxm6OeuwrC2vekLBYU6NQtXHcppSbM=;
        b=Pm72mLzz57M82YYB0QbWNXNiO2U/itT+MbzlhqpV7I4RGGR8N9axeyHC5rZmc+wRhC
         XzEThEHAqAx7lbSX5sg9AhVPkV56qP48PrZZUoxtCL8lrSYBYhSCRQiblGzpxXwL3b1p
         Jlx021mjzmXxl1NeDMOhaW6WWf97xY/zx3JKUhymljjPZtfUhAYyC3qmPsO8av9Q4PQ4
         EPikxh49BCOjeaDgt414KokejmbYCed6PG9D5OmWBhOvllcRB0h5WT7Bh3iam7DMOznI
         6MsDKPgRB1aYm2pj9vCKo4lykRXjFDSlZuGNV7h++C07vmX8dNSkdw18YTcubjyLOvVq
         bL/g==
X-Forwarded-Encrypted: i=1; AKwUvBwgXLu4xkv4dQxbfo7pRIld2urEv3vut//QAF1eBVD8Jq/Y/lfQX4w6boAlpWrSeheHfy5A/MR260AaWEQC@vger.kernel.org
X-Gm-Message-State: AFuF++k1cL6cIYOntisagqIpAS/6li/lH6JqucvTPPKVigvfQuNftmpr
	CjQ6Q2qfHmd8AsGhmhiQh4113usyyZAtjKolHFScICGQreYpM7lZfYB3BLiwapknhok=
X-Gm-Gg: AYBFou3BPhqoobPt7xo/UXh+pUgk0dDRHIg97GDRnV0cHvtIabXa5lfWiilXozS3ORZ
	0Pjeg00pWgoTmNVJh26NpqeFeCXcUx0Wp//Gxp05JMOuNuf6phBHOcQXvgeVdvmD7ymDuKkYjg5
	e2wDtvY3oW0pINEwIWIIowaeuT2aLtemsTrrWxnhv+nogsYRmYtRWEG3HLcx0dzPHlWD/75U9w+
	mvwp3SDtudj0vE4GEOr2Ay9zIacdbpfpIARg9XJyjFW+gXADPSX8gV8XnC4sbKpPwBM/HcCYKU9
	KCeOWme2g2TOeCWeUPtoK2od3PA+naSIsAlY/IUANGFmhuaY3zx+Jn8/3jS+R+U21d52wS+2++H
	rBM9tfNj5VNmoUw4vLlf3D5ne6ElhlYVSGKnSdJboUHaUp0d6Cow7VLkxHj1h6EIaWrhPs5yFr9
	4RTDy/uGKRoraVuLEaF37HWUfte2bREZ+UEqLxpUVWzDWcujPZXUOia6STiUqsM1iyF+ld+UJou
	t9tYPpfNCg+r6AjtO1ASR2tNv9WKyP54U8XAQ6iGYTY9VlpUv7gbfdag6gxxyE+01hwRSOUeTUi
	iT4RAgUHeiXQYbzgXgdlHzgTMS0tQ+xIhjGeoQsKRb3628EfoFK+3DAPMiRU2nPG
X-Received: by 2002:a05:690e:4549:20b0:671:4d0f:13e5 with SMTP id 956f58d0204a3-6717fd9e12bmr690811d50.8.1789761423797;
        Fri, 18 Sep 2026 12:57:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f1ff:bb02:6c7c:6979? ([2600:1700:6476:1430:f1ff:bb02:6c7c:6979])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67299104e3bsm407989d50.15.2026.09.18.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 12:57:03 -0700 (PDT)
Message-ID: <5da11ad3c9c7954ad52b04880b61d9cdcdd0211a.camel@dubeyko.com>
Subject: Re: [PATCH] hfs/hfsplus: serialize B-tree close against folio
 release
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Bruno Produit <bruno.produit@trailofbits.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dominik Czarnota
 <dominik.czarnota@trailofbits.com>, 
	syzbot+d729df28d933979e017a@syzkaller.appspotmail.com, 
	syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com, 
	syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com, 
	syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com, 
	syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
Date: Fri, 18 Sep 2026 12:57:01 -0700
In-Reply-To: <20260918130853.216497-1-bruno.produit@trailofbits.com>
References: <20260918130853.216497-1-bruno.produit@trailofbits.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 15:08 +0200, Bruno Produit wrote:
> From: Kyle Zeng <kylebot@openai.com>
>=20
> From: Kyle Zeng <kylebot@openai.com>

Why do we have the same email two times here? :)

>=20
> B-tree nodes with a zero reference count remain in the node hash
> until
> folio reclaim or tree teardown frees them.=C2=A0 The folio release
> callbacks
> remove nodes while holding hash_lock, but hfs_btree_close() walks and
> frees the same hash without that lock.=C2=A0 Reclaim can therefore unhash
> and
> free a node after close has loaded its pointer, causing a use-after-
> free
> or double-free.
>=20
> Detach each node with hfs_bnode_unhash() while holding hash_lock
> before
> inspecting and freeing it.=C2=A0 Drop the lock before hfs_bnode_free() so
> a
> large tree is not freed while holding a spinlock.=C2=A0 Apply the same fi=
x
> to
> the matching HFS+ implementation.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I think we need to have Cc: stable@vger.kernel.org here too.

> Reported-by: syzbot+d729df28d933979e017a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd729df28d933979e017a
> Reported-by: syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2eac7d175baf21e6a5d5
> Reported-by: syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7155b2fe09e033c91381
> Reported-by: syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dadeb387cede15eb11607
> Reported-by: syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dae7f2423f3648100506d

Does this fix really eliminates these reported issues? Have you tested
all of these cases? It will be great to have this clarification in the
commit message.

> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> ---
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++++---
> =C2=A0fs/hfsplus/btree.c | 11 ++++++++---
> =C2=A02 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8fc9..d85a1df9f 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -310,14 +310,19 @@ void hfs_btree_close(struct hfs_btree *tree)
> =C2=A0		return;
> =C2=A0
> =C2=A0	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> -		while ((node =3D tree->node_hash[i])) {
> -			tree->node_hash[i] =3D node->next_hash;
> +		for (;;) {

I really dislike this infinite loop pattern. Could we have a loop is
limited by some value?

> +			spin_lock(&tree->hash_lock);
> +			node =3D tree->node_hash[i];
> +			if (node)
> +				hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> +			if (!node)
> +				break;
> =C2=A0			if (atomic_read(&node->refcnt))
> =C2=A0				pr_err("node %d:%d still has %d
> user(s)!\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->cnid, node->th=
is,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&node->refcnt)=
);
> =C2=A0			hfs_bnode_free(node);
> -			tree->node_hash_cnt--;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	iput(tree->inode);
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 2ea8cd565..a90c9f416 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -417,15 +417,20 @@ void hfs_btree_close(struct hfs_btree *tree)
> =C2=A0		return;
> =C2=A0
> =C2=A0	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> -		while ((node =3D tree->node_hash[i])) {
> -			tree->node_hash[i] =3D node->next_hash;
> +		for (;;) {

Ditto.

Thanks,
Slava.

> +			spin_lock(&tree->hash_lock);
> +			node =3D tree->node_hash[i];
> +			if (node)
> +				hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> +			if (!node)
> +				break;
> =C2=A0			if (atomic_read(&node->refcnt))
> =C2=A0				pr_crit("node %d:%d "
> =C2=A0						"still has %d
> user(s)!\n",
> =C2=A0					node->tree->cnid, node-
> >this,
> =C2=A0					atomic_read(&node->refcnt));
> =C2=A0			hfs_bnode_free(node);
> -			tree->node_hash_cnt--;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	iput(tree->inode);

