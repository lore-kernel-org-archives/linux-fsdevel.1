Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862651;
	b=OmHezJdvQsxvRqMP06CHNCie2VLzU3QpaeMFsu2aphV57OHCEn7ErZ+MdXtQfBBp9huh
	 X7IcanoicdhDd5OMf21b3mq8mxF/4toTy+R/Cloh3OJPBoepCxPJfSfoH/kqkiX3n4vlT
	 N5FhpaSxVj/dXBVGtt+D8I0rIheTK73dAsT9lX0wjHbzkJA2ZOqweVbccF1I6VWuaXhoH
	 tsC3cUSubRJivrnRRQyueTr+n6djD1lqxKdbeRRpYvUEpanFhe10Fbs8zbOsHZEbcZ6Tn
	 79fzWetkJuh02cmPdO+SBK7z6kN0t62L8OHL73gNGxEB4BLWUa4yf+SJu/GDj1kC5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=BeJTPXMIERMMrOjPrnFZfmJDB6t3Gy24LCkPLnCbR9w=;
	b=HqgJ1WlCPq7CYyIqgxrE/8056JZgjs6koZVg5nQ2zYadD/Yj1JQ5MaQgSFN3by6pEbMq
	 /vbp8VPEfnrctnaFiK6qxf00KEZFTPYwSAh2yQV/LC8/gJWcUUeRzAoKQg6ouO6vpg0NZ
	 lwImbIZas0zFVo7qjsAqk+fXRPNpOyVUoABUdeN80mfVQMrnYsHAJ/zcJ6zbRhq/rMndX
	 5jUuf3RyHoofbthJGeXlBUBUYNwBOENsQXr7WqlCJFSl6Xzlx+MHBOQ+CR3AIemIgt68L
	 kfSMB8jkWoJEyYVR8EtCJae9KNF6ywhd5hq7LMhKWfDe/wLLcSGQEPcw8hwirPRtGwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lGEjHgln;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A9606A322
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 360A9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lGEjHgln
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b335eeb340so29881247b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794862649; x=1795467449; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BeJTPXMIERMMrOjPrnFZfmJDB6t3Gy24LCkPLnCbR9w=;
        b=lGEjHglnyr0UYlPMSETyuvVtDRUA3S1UDG8MEEw9K8MW3eIw8llGiyCc1zQVQNqetl
         HRawZrrApvTHVC8JD9kq8jHlbz3eb90I0RvuJ5ZjqzZ/kW50uBRQlb/45GgssbovQvNN
         gNnBrlT/Tf3wnubZfP54LO9sOexeaxAEilFko1Agq514kj2BHL3ZQjpmOecmKo2OmFJb
         owyoVuQAMH3HNGJU7WenjfpUNDX9Cm04XJU7foUTCycoRT2dnlThpmwuc6qqhiRlxYiA
         q0W9cPAR7ja13A0gUVSmqUgvl7YiPC0mEOkOBViutDxxiplimUoB6XGEO3VOlp2WTzf+
         odLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862649; x=1795467449;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BeJTPXMIERMMrOjPrnFZfmJDB6t3Gy24LCkPLnCbR9w=;
        b=csWcfZOWC0bhYsVc14mhPpYLF5b/cCQ4LLfmMyGjucW+vo4NTx0By4yksqLO6Gfriq
         XhBYhSnIjDNl90kckPLIVpsUAJxu9i2oBhc/pA1+rpcl0VNUXkzkhCvD0JzzaxJM1gxn
         jc9wNfeYYxmouTGh02y00B7m4JNYcuVT7dj8u8Gwr66NjmQH2Zj8dSFmwm6SZSkFaeTO
         sx9yjfQg2WzEKb+5rGWLkMU+vgduFiUqMHu6tgH3k/efID6C1WN+7vuEGb2EiXECEsVZ
         B597jqeswyi0AI6DhBe9RVQHIdvswlI3Q4+/EslcTg0Pio0J8y1txv5tyYDW30Nmwcqi
         NjiA==
X-Forwarded-Encrypted: i=1; AL+hErFRZbvMvigEoFtugyGOxR3CQZDB9cwQHCQON5jzStwHJR3mut3pUcyuqDbiGzPDIERmlTYoGpQrQxHBe/FQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9OoYxvJtfAPE56iUCU/SAaXpbIeFWKkZqzLMtTFtTkR5ON8JAU
	fL84FEYusrt/19FJyN4PG5Zz/4BMNG4hSQjGdRMSDSgh+sUyugo8K+PpX1/KI1D/o6H/87L8ZXJ
	H0K1XzH8=
X-Gm-Gg: AZFdTZdOZy6Yh1iohVh3tYUIhYWf3aFMUfrie/N3Ho+tpDh20vabFfpCz4X9ftXIVRx
	AlklhxyxpeDK69z0nhoClvvD0/n/T0pGREY42zGP3yYrsqCiAB/8vcq6LvRNzK7USfi7WENtKkf
	jsR4+l3XW6bnhiGMOBbTmkm524+RJgD5z3aA9OK7IeyQRVJgGS9UV+cIvEUJiyVAlxr3O1szsdY
	UVw3V5JO4cPRLCUQ1FXXney5Ds2I0OjaaZnQcGrGzFKy05niQjY+tHZt/c2Mg6ToXvxT08Q+yji
	AMDmWHt9c86UmISenrmcU0Hb457AQWz59SaLKT88v1rLZ5HjLJQEODk3ACknxUBYRnzJRTeJUYW
	IHet8afUhJqsI/iUa3yII6oP5ziQrqpWEHrZAY0kTPHDflPqq36XVGdIP9s8lpLLSnXv0ZsTOyw
	8K04JbQ2Yqk/pY7CyJ5YfO5kdM0b16ACExqtuorwYvY3m4NDufs5+zWd40JTdLHNuzMwppjl0Go
	dk6OcLIj9ereU6lyatyfYhfJ4l+40LR2IATiQ1dteE83PmxYIQTia542+WuMTkLWzHReS2l8zsP
	WkNThuUMSajmiJRqnoWO//KBn7kvorgVUyAXYh5PGbcDqgSupkdS8+jr6/+Ce4MBHinDoToEMk4
	LZyYgnoWShaFg5QCLxu5resAXq4PFJJExhA9+bb/e3bs0C+vM8XnkVLGIAOgcP+bFzxxk83tdAp
	3yB/RrasXxseoKk/1mM24=
X-Received: by 2002:a05:690c:e1d0:20b0:8b0:acc6:8e81 with SMTP id 00721157ae682-8b4aa0e16a4mr38105927b3.1.1794862649089;
        Mon, 16 Nov 2026 12:57:29 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:48ee:a3ac:5a4b:3831? ([2600:1700:6476:1430:48ee:a3ac:5a4b:3831])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dba3a0094sm3402847d50.3.2026.11.16.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:57:28 -0800 (PST)
Message-ID: <2e910d5d5ab8dc719b4e540410a9e1024eafdfd5.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: bound hfs_bnode_read_key() against the
 per-tree key buffer size
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 12:57:27 -0800
In-Reply-To: <tencent_EA39F5EE5B6CC4D989CDD435CACC4731AA05@qq.com>
References: <tencent_EA39F5EE5B6CC4D989CDD435CACC4731AA05@qq.com>
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

On Sat, 2026-11-14 at 18:00 +0800, Guikun Yang wrote:
> hfs_find_init() sizes the per-tree key buffers from max_key_len:
>=20
> 	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
>=20
> which is 24 bytes for the extents tree (max_key_len 10) and 1036 for
> the catalog tree. hfs_bnode_read_key() however bounds both the copy
> and the reject-path memset against the generic key union:
>=20
> 	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> 		memset(key, 0, sizeof(hfsplus_btree_key));
> 		pr_err("hfsplus: Invalid key length: %u\n",
> key_len);
> 		return;
> 	}
>=20
> 	hfs_bnode_read(node, key, off, key_len);
>=20
> sizeof(hfsplus_btree_key) is 518 (the catalog key size; the union of
> cat/ext/attr keys). For the extents tree the bound is larger than the
> 24-byte buffer it protects, so the check is inert there: an on-disk
> key length between 10 and 516 passes it and the memcpy overflows the
> allocation, and a "rejected" key length takes the memset path, which
> writes 518 bytes into the same 24-byte allocation. Both paths were
> observed as KASAN slab-out-of-bounds writes on the writeback path of
> a crafted image:
>=20
> =C2=A0 BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x30/0x5f0
> =C2=A0 Write of size 502 at addr ... by task init/1
> =C2=A0=C2=A0 hfsplus_bnode_read -> hfs_bnode_read_key
> =C2=A0=C2=A0 hfs_brec_insert -> __hfsplus_ext_write_extent
> =C2=A0=C2=A0 hfsplus_ext_write_extent -> hfsplus_write_inode ->
> hfsplus_file_fsync
> =C2=A0 allocated 24-byte region (kmalloc-32) by hfsplus_find_init
>=20
> Bound both the copy and the memset against the actual buffer size,
> tree->max_key_len + 2, which is the natural limit for every tree
> (the extents tree can never see a key above HFSPLUS_EXT_KEYLEN on a
> well-formed volume; the catalog and attribute trees already allocate
> buffers that cover their full key sizes).
>=20
> Tested with the reproducer from the bug report: the extents-tree
> image that previously wrote 502 bytes into the 24-byte allocation now
> fails the bound and logs "Invalid key length"; the negative control
> (NUL-terminated short key) still parses and writes normally.
>=20
> Reported-by: Guikun Yang <yangguikun19@qq.com>
> Signed-off-by: Guikun Yang <yangguikun19@qq.com>
> ---
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 3a1a1fa6f..0774b945c 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -84,8 +84,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 2;
> =C2=A0
> -	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfsplus_btree_key));
> +	if (key_len > tree->max_key_len + 2 || key_len < 1) {
> +		memset(key, 0, tree->max_key_len + 2);

I still don't follow what is the problem you are trying to fix. And you
fix it in much worse way. Before we had sizeof(hfsplus_btree_key) and
now you suggested tree->max_key_len + 2. I dislike the hardcoded
values. I tried to understand your explanation of the problem but the
explanation doesn't make sense to me.

Usually, we call hfs_bnode_read_key() for struct hfs_find_data and it
contains hfsplus_btree_key:

typedef union {
	__be16 key_len;
	struct hfsplus_cat_key cat;
	struct hfsplus_ext_key ext;
	struct hfsplus_attr_key attr;
} __packed hfsplus_btree_key;

So, we should have enough memory for executing:

memset(key, 0, sizeof(hfsplus_btree_key));

So, what's the problem are you trying to fix? Why tree->max_key_len + 2
is better? What if volume contains corrupted max_key_len?

Thanks,
Slava.

> =C2=A0		pr_err("hfsplus: Invalid key length: %u\n",
> key_len);
> =C2=A0		return;
> =C2=A0	}
