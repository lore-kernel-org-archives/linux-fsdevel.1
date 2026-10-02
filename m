Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD3399375
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965132; cv=none; b=sKZl81cP5DH5UJb026rEo859qJuYMH38cSDol2P1SKuIYdawSB2RLsbd58h2wERCvsXqd5/1WCPNtHe2I4DoNsJUXlywmOjbuG024XCZL4a1Ec1MAa5JVOyPD3s6BPUy3MiHJbihsMCirHORBhBqgryj+tMClieuYBkoh3TX+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965132; c=relaxed/simple;
	bh=q1iSZPpA793Q+w4WY8YfDeHvEFRic5k335ibdfXa7qw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akwE01E5vDua1ShDwjRrZm3exz0ws6Uge55cjhG/+eMhlOHCsPTKsf+t3bx2a+Vmb3KX5gwbGwCBkyZrvaVHyNx5wlRj8CmJ+sgr5p0jl1BW70GPqcDKz9ndurSBjGyAtQzzT48glLyKSxrdww83KMWsU8KQYqZR+MSnv86WBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ipOQ2oYT; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ipOQ2oYT"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-672a4eb7f6dso951638d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790965127; x=1791569927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1iSZPpA793Q+w4WY8YfDeHvEFRic5k335ibdfXa7qw=;
        b=ipOQ2oYT10gRk+wfaf5+PCoSCdiO8SBdZp8epf0/IL2QyWJ96EAIOWi/rGGD2ZV2Xv
         +KktXFBQ9be8t5GEArI/G7Q75fq/b+iaMPjFM/6vJPlrToN/hXpNx8JMh7/VaB9AYEUF
         e1auCzwb4uQv0NjxNARoUZHPD3bMqcOAQLGibVwapmdjDgOWZQYXjdsBosvIcy8MG7f5
         InWUY3up1p649k9PX54XVzdcD0g8ZezKpqt7pexo+79JCoAljirRymzogyfWFOh+cdGp
         8Dcoc0/mCXf6YQX8remHFyxdECFX+d26mtN8G+VA/H7BLpW4Tqan+faMdPo4ANKlmwg6
         bEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965127; x=1791569927;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q1iSZPpA793Q+w4WY8YfDeHvEFRic5k335ibdfXa7qw=;
        b=Pi5wC+BQNG29NaLNVhAN01JbsyMKDY3hW4MIK/ymLpBSh2FBWZblEp2IJEDqZr7cAX
         yz+hMcFCVHsYjbYU4w1AHI7E5kuWBxU2557i5EEe5QehW4MAOMk8kfq7qIggMsaNKO5M
         p+zt+PXIJtGUMVVfEr6eoXrl8XEuz6IeA+k71w8fRpP0iCEZp6sKwBVSq+36HAQP00oL
         MFwx6Lqx8svWBF2/v+CF1sCQhPx63ksx9gvyWd8GbX9fatOHNkb0IU7D7wegv2kngr2i
         jT1Wk9+lYJafnpmaONZobozPu+1x5IkpE0Cgnmd5Z6ak0+VCDwbtMe780sv9iupWIyGv
         /YnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzct9duqnjoqWt9WBAbedlciC70g4BC1mMHAOvtmcWqns0sQe8wPZu1KdjgIIzzdkQzd4XgQdeMonWvRGn4@vger.kernel.org
X-Gm-Message-State: AFq9FYKFaTy58lgygOMpaeoddXer1sFSWnXYAAH6sB3uV1RqoXxGIOWt
	izWMSC+jC+JVEZu8tS+pwqKkQfEa927bw9Db1skQbUhx8NFdBnLzioSoLAV1cSZRQ9U=
X-Gm-Gg: AYBFou0huaCy9LPAK2niOw3joiSJ849FZ+wALB1xaKA7SoMLZuAk1SDqHQmI6uHRDeg
	9qqwRQ1B8+n/xYvGtzSE9hjUb9Z47CcCPzlpW9zk11MmcBuGHQodvFke0qaXuO/zITnZUpMI+6H
	f+LgxYKk5YsZAGo91BAWLZIcD+6FPlO49VAQz4GFlKtUOjx/ZKWbNGkLPXLSGOHlHFUbvmsTyCV
	EvG6jQ4KJpC/Df+V8f7WfyG+kjj+UzdkAflZWivGNG6saTmt269LfXQ7O4tMvCPkRph6RnmASaW
	cmSbLjWarvBUmgDja0/bOVP5eW+UqloRr6mOixS6AnzXo3coj2s4SFSPEyVpHscsAOJmFreagI6
	urhiH/Qlg6ZSCmUqtcj0uO2JVrtiKsInlanF/Hl93UFsdXSG0bPsKtKI6/GnKqk6rEmzCarUPht
	k95j94RmwmllhXX6BX3YB3dyuKwHJU4EewC61NTBxUwXcT6G5ygbxQ9dMe4Jujt4GjLLlSSIIyK
	6By4ilRndByOLDTNczzcYBTYcf560HfyoHAC72vWqHZM4QxIC+jrljb0+Rtu7XHwgwChEgqHZu/
	Guv8fvcrtWXpZanWaURYxP7T2OsGxzIkJ6nK9D3H76+AvVBUfIwBxv03VNo=
X-Received: by 2002:a05:690e:400c:b0:676:938c:5634 with SMTP id 956f58d0204a3-677bd328dbdmr179940d50.38.1790965127243;
        Fri, 02 Oct 2026 11:18:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ec77:47c8:250:c58? ([2600:1700:6476:1430:ec77:47c8:250:c58])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677ac50d04asm1467036d50.6.2026.10.02.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:18:46 -0700 (PDT)
Message-ID: <e03cec7e17be27fde6b51957c61fb6958b9832ad.camel@dubeyko.com>
Subject: Re: [PATCH v3 0/2] hfsplus, hfs: fix B-tree node leak on
 hfs_btree_open() error path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 11:18:43 -0700
In-Reply-To: <20261001213807.1519745-1-guvenlik@noroxi.com>
References: <0de056179e3e0a7c4ef525cdb143647b7493dc71.camel@dubeyko.com>
	 <20261001213807.1519745-1-guvenlik@noroxi.com>
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

On Thu, 2026-10-01 at 23:38 +0200, Mahmut Emin Kurhan wrote:
> This is v3 of the hfsplus/hfs B-tree node leak fix, rebased onto the
> for-next branch of the HFS/HFS+ tree as requested.
>=20
> The leak is unchanged: hfs_btree_open() can fail after the head node
> has
> been inserted into tree->node_hash, and the error path does a bare
> kfree(tree) without freeing the hashed nodes. The fix factors the
> node-hash freeing out of hfs_btree_close() into hfs_bnode_hash_free()
> and
> calls it from both hfs_btree_close() and the hfs_btree_open() error
> path.
>=20
> Changes since v2:
> =C2=A0- rebased on for-next; the extracted helper now wraps the hash_lock
> =C2=A0=C2=A0 serialized close loop introduced by commit dce0e0248205
> ("hfs/hfsplus:
> =C2=A0=C2=A0 serialize B-tree close against folio release") (Slava Dubeyk=
o)
> =C2=A0- on the open error path the tree is not published yet, so the lock
> is
> =C2=A0=C2=A0 uncontended but kept for consistency
> =C2=A0- no functional change to the leak fix itself
>=20
> v2:
> https://lore.kernel.org/linux-fsdevel/20260930232312.1405042-1-guvenlik@n=
oroxi.com
>=20
> Mahmut Emin Kurhan (2):
> =C2=A0 hfsplus: free cached B-tree nodes on hfs_btree_open() error path
> =C2=A0 hfs: free cached B-tree nodes on hfs_btree_open() error path
>=20
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0 | 40 +++++++++++++++++++++++=
-----------------
> =C2=A0fs/hfsplus/btree.c | 41 +++++++++++++++++++++++------------------
> =C2=A02 files changed, 46 insertions(+), 35 deletions(-)

The patchset looks reasonable to me. Let me run xfstests for the
patchset. I'll share the results ASAP.

Thanks,
Slava.
