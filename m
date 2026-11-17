Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954151;
	b=Qw9p4MpVmL29+qleB0gCqzxxbSLTu9LRtTDG5zV+8bdVi9HzcJLSbcIKQKIqEmIp5dLJ
	 8bIiXZ5j0Bve/K4QKIaAFJOJTb8xr4MCAzM3ZHIpRdQfEuVJG7IRnCzqg/VJN54ziAcGf
	 Vn07TZE6mgFGTF2R9SGI0AIGQEAdNnOeuyuh/OFn39WE5oUDH75WO7BTkVzQ1lf6eHfQT
	 2mAkTPo2K+NfJzNCZ5QzQld4A2IyZyVFQk2lUgbBT8WpvJjLbppLH8Dbe6CFFmZ3Vi1PC
	 9+Jfw6684qFOsD6UaSlzSGfL1vHnFLJadw2aqxlEUbveKyRtdSBD27Um2GR0tgI4UhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=BPOoxnp68VvHIfQPbQ8/kLgA/UU51CReEkh25KzMnk0=;
	b=4POB2wj69Yddp6g5yez6OwN97/9mGcNNI8klJA9mCrgylP1XOyYqnRUubi7212egXC7H
	 QLlXSKGvT4PTfNvv5coQ/3e5piLgH6tE+ueOPz97CpG42SzfaZBfWBgHQxHSacRUIYf0G
	 yIiZi/NB3Kl2TFU7w+ItW1Odzz5Rdpw+Sxazvm4uZK2RH2KpWo0e92gFN/KdbkI1AW2O7
	 PuUvqO8P75srQoDkOJ11W0TCqXlyVgs69J0sPf4+55DyrYHArQRJ02JTb9zxDjJDh+wKU
	 yzAeGozXjCggr3k6vSPvZVZ/KxixOJKJcNEJl++eedc3IGGlbujTJXYCZWGnJGg6XpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Y6+PvRpn;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A11606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 22:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2A11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Y6+PvRpn
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b315dd057bso2037987b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794954149; x=1795558949; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPOoxnp68VvHIfQPbQ8/kLgA/UU51CReEkh25KzMnk0=;
        b=Y6+PvRpnRsFmOY3aoCmR2ePK2d60JIWwDBoZVSJWnsvZq3JWDcSCxMNMMpjPpkHSG9
         AGENckrswucqKmhx00PH92MZRLPBANkYAWKc69EuPerft9FRc5WwehKUVvyNb66kouPx
         CDv/D6BqHQSgLZEJZkRbyYilFWGGd10K4UXMPn4DYV5UDDH9La9tGxzPQ+JCCVQC4n6v
         4zwQSS6j9EN8ndbEuWeoBsDagFRQhVGtbKVUNM38O83X4av8O8eLnZjTvOI8TW8sEqay
         UGEgleVgmieoYz+KFBCBed8uZA4K0dbq5ViKP0C6EpJnSq/zdkWwFRbvZ1yP87zY/UEQ
         yZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954149; x=1795558949;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BPOoxnp68VvHIfQPbQ8/kLgA/UU51CReEkh25KzMnk0=;
        b=zRgutbVZp0CxXsb2B1y2x5cPh54/BTkEzSCEhLn1qVsajldbgzn+U8cKPpgUsH+c+O
         RfZN44SWrwbqApjr0TPHQLFeV9KGXIzpt3HdmEbZD58vJBkM29JjdZQ1nKx1pc0chCrM
         oHPRgJeTQKbOjYOi9YL0hyK/9iK5X8y93qbTTp7SYSHqckmWAJA5ytYDobTyVFYED/sy
         pTG1GY/C9Z33f3EE+mZPOckRiyLMsMQRwyykjy2XK/y1XfUdt3jKo676Dm78vynOwFLD
         xEFn+AaIXCYCci4OZGcB08LwhqJTX24/g5gWY+n4yDsiLesAYIrrhaAgb2RVurac4+49
         Qo7w==
X-Forwarded-Encrypted: i=1; AL+hErEIOqPsGTzrh+d2KbU9qydPkaPhMVBVJ4ce11GsltEUNrzxWsOT+OSao+plhsKjCdZ1n42ByMbLlyGiNgSS@vger.kernel.org
X-Gm-Message-State: APuU4Z8HfBmpcy2JgMueAgTy7LBXR8Icuxo1CZSlQDt4NXShwJpBi0tD
	KYr6m3am5wprFw+B4OCMQVpr+MfkxkvV+Dc7Suz4vCWYhKk2aCMaGrAcD72bnXz5hPE=
X-Gm-Gg: AZFdTZc0rdPYC0T3o7+CEnNLq35uUuzBN8w1Lcgsh1EcV16oGTn1O++Peq6frkaHBuS
	pLrOzjjJ02iPMC7ojOsWk4TjkKVvvPqMWBNXEy6YvWWS71wqNjzyy77eolEwEo0eBYCg8HCS9BY
	bEaUVXmVjO0wmkvehMgVSv59EcWAi87DmJSIQVUHDs1+MSqfMG4u5CQsMncMu7qKUyM60DzINo5
	UoWzXJmpnSVignghIWWN74CyFFhzpDRb/d93DslB1Z/TpUvjydstggahWKfC25nmakS1cv/JhqL
	C2yRv3prWnGjmYKH+So5sEm7BvQbB9Vix66hVbfGwYwCKJPBhKAPm89qV+maDbXEBaRJqLCqn0v
	sz6ib5Qf495EGfMBfdJMTaxzpMkSe43HoKxSn2FeKyMnKm5GNoCdsbfKu+yFTtg5JDDEy7djgZm
	8p0YTeXpdHxibT0tdJ02O2hiVthaC1/Ah+MIg6YlZvtqN5E7u1mQRwDPV4WnUJqF7HIQ6jeam+0
	lFcC1sITUlDLZUMNyieX2k5DbxfcSgoFXLa90Rhgvkqi4kxPNVr0pKiYAFlSdSos61sGFK8uEk1
	UoB5AFLuS9qO5KzrsBMCwT7lSY9R6VvquZP7JQPBKkFN466VezQKtCWPS6NKgILTVKtJoLwGvf7
	dxYXSlw7fY7P1SKUNid9vkXhT1iqzeMcaDKfStybvYKcZ0TdHU+vzIb8G70/hbUHzg3IdNJQdwj
	Z4uhXSPBk/HcIgVJq/gHc=
X-Received: by 2002:a05:690c:3083:b0:8b0:dc04:b378 with SMTP id 00721157ae682-8b4febda21emr3191597b3.9.1794954149355;
        Tue, 17 Nov 2026 14:22:29 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:d1c7:8722:e551:bec4? ([2600:1700:6476:1430:d1c7:8722:e551:bec4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe0f80f1sm7625897b3.33.2026.11.17.14.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:22:28 -0800 (PST)
Message-ID: <ea8b2f81c542c98f6bec6025e140a915accdd53c.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: bound hfs_bnode_read_key() against the
 per-tree key buffer size
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, =?ISO-8859-1?Q?=D6zg=FCn_K=FCltekin?=
	 <ozgunkultekin@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 17 Nov 2026 14:22:26 -0800
In-Reply-To: <tencent_1CEFA39140271AD3A828251FDD28B254CE07@qq.com>
References: <c44-hfsplus-extkey-oob-20261112@qq.com>
	 <tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com>
	 <patch-hfsplus-readkey-bound-20261114@qq.com>
	 <2e910d5d5ab8dc719b4e540410a9e1024eafdfd5.camel@dubeyko.com>
	 <tencent_1CEFA39140271AD3A828251FDD28B254CE07@qq.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 22:30 +0800, Guikun Yang wrote:
> Hi Slava,
>=20
> The mismatch is between the declared type of fd->search_key and the
> size it is actually allocated with.
>=20
> hfs_find_init() allocates the key buffers from the per-tree key
> length, not from the union size (fs/hfsplus/bfind.c:22):
>=20
> 	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> 	fd->search_key =3D ptr;
> 	fd->key =3D ptr + tree->max_key_len + 2;
>=20
> So search_key holds max_key_len + 2 bytes. For the extents tree,
> max_key_len is forced to HFSPLUS_EXT_KEYLEN - sizeof(u16) =3D 10 at
> mount time (btree.c:318), which gives search_key a 12-byte buffer.
> The declared pointer type hfsplus_btree_key * suggests 518 bytes,
> but only 12 bytes are actually there.
>=20
> Now in hfs_bnode_read_key(), the existing bound is the union size
> (bnode.c:87):
>=20
> 	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> 		memset(key, 0, sizeof(hfsplus_btree_key));
> 		...
> 	}
> 	hfs_bnode_read(node, key, off, key_len);
>=20
> key_len is attacker-controlled in the leaf/VARIDXKEYS/attr branch
> (u16 read from the node plus 2). Anything up to 518 passes this
> check, and hfs_bnode_read() writes it into the search_key of an
> extents-tree hfs_find_data (a 24-byte kzalloc total, of which
> search_key is the first 12). That is the slab-out-of-bounds write
> from my report:
>=20
> 	BUG: KASAN: slab-out-of-bounds in
> hfsplus_bnode_read+0x30/0x5f0
> 	Write of size 502 at addr ... by task init/1
> 	 hfsplus_bnode_read -> hfs_bnode_read_key
> 	 hfs_brec_insert -> __hfsplus_ext_write_extent
> 	 ...
> 	Allocated by task 1:
> 	 hfs_find_init (kzalloc 24)
>=20
> reached via hfs_brec_insert() -> hfs_bnode_read_key(new_node,
> fd->search_key, 14) on an extents tree (brec.c:169); the parent-key
> update path at brec.c:151 reads into the same buffer the same way.
>=20
> So memset(key, 0, sizeof(hfsplus_btree_key)) is unsafe in this
> function too: the 518-byte clear runs off the same 12-byte
> search_key, which is why the patch bounds both the read and the
> clear with the same expression.
>=20
> About "what if max_key_len is corrupted": it cannot reach the tree
> at all. hfs_btree_open() validates it against fixed constants per
> tree id (btree.c:318/331/350):
>=20
> 	case HFSPLUS_EXT_CNID:
> 		if (tree->max_key_len !=3D HFSPLUS_EXT_KEYLEN -
> sizeof(u16))
> 			goto fail_page;
> 	case HFSPLUS_CAT_CNID:
> 		if (tree->max_key_len !=3D HFSPLUS_CAT_KEYLEN -
> sizeof(u16))
> 			goto fail_page;
> 	case HFSPLUS_ATTR_CNID:
> 		if (tree->max_key_len !=3D HFSPLUS_ATTR_KEYLEN -
> sizeof(u16))
> 			goto fail_page;
>=20
> A corrupted max_key_len fails the mount. At runtime it is always
> 10, 516 or 266. And the bound stays consistent even in the
> hypothetical case: search_key is allocated from max_key_len itself,
> so a bound derived from max_key_len can never exceed the buffer,
> whatever the value is.
>=20
> That is also why I would argue max_key_len + 2 is the opposite of a
> hardcoded value: sizeof(hfsplus_btree_key) =3D 518 is the constant
> that has no relation to the allocation - it matches the catalog
> tree only by coincidence (516 + 2) and overshoots extents by 506
> bytes and attributes by 250 bytes. max_key_len + 2 is the only
> expression that tracks the kzalloc() in hfs_find_init() one to one.
>=20
> Both sizes in the patch come from the same source: the check
> (key_len > max_key_len + 2) and the memset use the same expression
> as the allocation. If you prefer to avoid recomputing it, storing
> key_buf_len =3D max_key_len + 2 in struct hfs_btree at mount time
> would make the correspondence explicit - happy to rework in that
> shape if you prefer.
>=20

The real problem is in function declaration:

void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)

We should not assume the capacity of buffer but we should be informed
about it. Probably, we need to have such declaration:

void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off, u32
key_size)

For any operations with b-tree, we need to prepare the struct
hfs_find_data:

struct hfs_find_data {
	/* filled by caller */
	hfsplus_btree_key *search_key;
	hfsplus_btree_key *key;
	/* filled by find */
	struct hfs_btree *tree;
	struct hfs_bnode *bnode;
	/* filled by findrec */
	int record;
	int keyoffset, keylength;
	int entryoffset, entrylength;
};

So, we need to store the key capacity size in this structure during
hfs_find_init() call. And, then we need to provide this value for every
hfs_bnode_read_key() call. And if we can rework likewise constructions
tree->max_key_len * 2 + 4, it will be really great too.

Does it makes sense for you?

Thanks,
Slava.
