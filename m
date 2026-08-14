Received: from mail-yx2-f4.google.com (mail-yx2-f4.google.com [74.125.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF1343D72
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786680626; cv=none; b=jR/rAk8koREINjc2Lsoh0QY9KdU0VuRDHOy8AhuBQoqb2lWryqdysCYSnOGcAl98Bt5dAGOvlAMbkPRAY8qH7BaxM6YzHQ8xg+ZEpheV5lMIYMvhD3txCmilklBaGuvDhUjoJmlBjSBjDtU5QfGrANDEExZKibIj2btRDTg/ayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786680626; c=relaxed/simple;
	bh=vG/8uYsHOPgwyk/6c6sgufFUG4YVR15UaPkJUXr81yE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqTZ4fOtSqLLfZyxb8vZk0gb30da9wTW4AqK4/VE8S71cp7pMCP63tntK4DzRL73fcOj54czytHMAKtAJuVQJTM7Q/IjGKpStqsnM7qvD07JibrNQ+0fxNZG2wfp5HCg65KWyQFKJw33Swujurq3dovcudDxr2JNmgnG17Iilrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=jtxC1MMY; arc=none smtp.client-ip=74.125.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="jtxC1MMY"
Received: by mail-yx2-f4.google.com with SMTP id 956f58d0204a3-66c70bfb18eso211824d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 21:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786680624; x=1787285424; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkdBsDaRZ0wvIKJDl4XuYIXFvkp9PV+vsxOtXR4sdTw=;
        b=jtxC1MMYWrL0MwLk+cCedaOUVxMnupVhQK4/PcDpfSCJpR9FPSROJ03QVmOCDzjIIl
         h5RnGyG+qO/MgWO9DQjNpmMr5CbLX5Aj8JCdREHOxvsFOmIN+qeLXkjN5EnY+ZAD2ghZ
         W4WPFakmEWcziJc86wKG7LDeNdNH10ZHBAUUdZKoqbKiXyhCLdYKc2vEh/rpVoXTbwxx
         lXHxmFW5h4VtAHZSSMkGJO5Ox8HmHvUsG8+1zZERVK+bXR5FlJWFhZtzmpXO2Rm2atlH
         YhM+IyXcjD5G4iEu8ANcvrERI1W5by0ON5VeGzK8VccrftD1XLyaQ9lUNyGhyp51Va9m
         M1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786680624; x=1787285424;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YkdBsDaRZ0wvIKJDl4XuYIXFvkp9PV+vsxOtXR4sdTw=;
        b=hCar7m5Dd8yCCnwp4QFk3lD93zNRZp/JI7pYGyRYlC7xaXbBTpax7nLCQJcU5py6nS
         P0qQYyK4SIwhex13y4h6OqptnI4QYtep9wpAAIV+U/B/bQFK4sS8UdNVvs5yuFWuV6A9
         DbVLwvjKGbA10CNW4A2u/3kTxNZdViqnAfZ66FdArGxuxLzG+PcqLnVDC8kFfNXKXDhz
         dYx7vkNQTo+Bqhrf4eeC+cz/mOk8otY/yU2LVN56nAQS1V/GeAD++0D5Dm1zmudJZ0KH
         CPxr14OGWj3zAJ1BBlJWqIRuUlKVJS4e0js3g6qqdtKLnsoonrv65nfp+S4/1/dXKEwU
         jyYw==
X-Forwarded-Encrypted: i=1; AHgh+Roll+KFzd4+Ny3tEU23HbzshBdfOAPQq2JJpymAyBSeBFeLJwr9XjUL2oecRkT/jRs6mZna8g1rVr7tP7qP@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8MNpvXgmhJ3vmyzvsdS53IiTehB3ej9g6kG3ryV0yUqh13Vu
	fq+2HEd5MuPc9mz/anefocREFCm8n3CKJTrjvXU3ab69MluRATG9uEq9z7nkwhEQB/GB7vd1g+Z
	d3o/mKFL0RJvr
X-Gm-Gg: AR+sD105iS0iT/W5U3aTgoHG0ERbZChFJlkTJ0uBSkbPRKVWTwhER5mlkVucZ9u2R72
	DNzElnRmg2gLV7qw/h7QN98YSYAPjOxo38GELZH98cFQhgNTAvqtVyy0Gs1EDiU6+6V0qzB5G9C
	D7nvqGs09mNJ2sFLm4rfIQ2ZUXwdqPYCtbLmlE9jrwEIakNYEPkRy8iP+yk0WUAjLTh/7aezZwr
	BXHQAh+DEGMk73uZlZpgT+dGx5zioxevNmbKK9PrwhE/H5v4NBK88vC/i1gBJeT/hm+ApyeARok
	pTo1w6oLCnXsiJl7yy6xtMEu3IMEoKsjA4mcWtDkh0AzTkSdoR3yr4fw9eGye9BiTDXUrPWrX/t
	30j0wphJ1Tc6M3KzCZq98sV7/mZOxypAtIwLlKIFTFEcuKTdWE+g98UlvfN2rRfGZuGlPm/wAu3
	ATbaTkqnIFuMPgIIHqSgYJyzL3pQahA6OPl+tYs5V5LLSh5TT368uklsZRr1VT78B90cDfsqaQV
	85r4xTGnFVOFpDzHx9xLymVw1qVYj5MHP6BGv3TW8QMrkVsvxzx1s5iFjcM4fIkzTn86i33Npe6
	W1EvjEVfGjgw4yGbMQ==
X-Received: by 2002:a05:690e:150e:b0:66c:484c:867f with SMTP id 956f58d0204a3-66c72d2c9d0mr1244458d50.45.1786680623676;
        Thu, 13 Aug 2026 21:10:23 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:7c1e:d951:252e:7fc3])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c7934f51esm311879d50.17.2026.08.13.21.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:10:22 -0700 (PDT)
Message-ID: <261014baed881dfcad5594a12753db7f1291eda3.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfs: detect node 0 btree map corruption at mount
 time
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Tao Yu <tao1.yu@intel.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org, 
	syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com
Date: Thu, 13 Aug 2026 21:10:19 -0700
In-Reply-To: <20260814023150.3482810-2-tao1.yu@intel.com>
References: <20260814023150.3482810-1-tao1.yu@intel.com>
	 <20260814023150.3482810-2-tao1.yu@intel.com>
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

On Fri, 2026-08-14 at 10:31 +0800, Tao Yu wrote:
> HFS+ already validates that the btree map keeps node 0 marked as in-
> use
> when the tree is opened. HFS lacks the same check, so a corrupted
> volume
> can proceed past mount with a broken node bitmap and only fail later
> in
> write paths.
>=20
> Port the node 0 bitmap validation to HFS. If the header node is not
> marked as allocated in the on-disk map, warn that the btree bitmap is
> corrupted and force the filesystem read-only so users can repair it
> with
> fsck.hfs.
>=20
> This keeps the HFS mount-time behavior aligned with HFS+ and catches
> the
> corruption closer to where it becomes observable.
>=20
> Signed-off-by: Tao Yu <tao1.yu@intel.com>
> ---
> =C2=A0fs/hfs/btree.c | 60
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 60 insertions(+)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e86..14114318ec724 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -15,12 +15,59 @@
> =C2=A0
> =C2=A0#include "btree.h"
> =C2=A0
> +static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32
> node_bit_idx)
> +{
> +	u16 rec_idx, off, len;
> +	u32 byte_offset;
> +	u8 byte, mask;
> +
> +	if (node->this =3D=3D 0) {
> +		if (node->type !=3D HFS_NODE_HEADER) {
> +			pr_err("hfs: invalid btree header node\n");
> +			return false;
> +		}
> +		rec_idx =3D 2;
> +	} else {
> +		if (node->type !=3D HFS_NODE_MAP) {
> +			pr_err("hfs: invalid btree map node\n");
> +			return false;
> +		}
> +		rec_idx =3D 0;
> +	}
> +
> +	len =3D hfs_brec_lenoff(node, rec_idx, &off);
> +	if (!len)
> +		return false;
> +
> +	byte_offset =3D node_bit_idx / BITS_PER_BYTE;
> +	if (byte_offset >=3D len)
> +		return false;
> +
> +	byte =3D hfs_bnode_read_u8(node, off + byte_offset);
> +	mask =3D 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
> +
> +	return byte & mask;
> +}
> +
> +static const char *hfs_btree_name(u32 cnid)
> +{
> +	switch (cnid) {
> +	case HFS_EXT_CNID:
> +		return "Extents Overflow File";
> +	case HFS_CAT_CNID:
> +		return "Catalog File";
> +	default:
> +		return "Unknown B-tree";
> +	}
> +}
> +
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
> btree_keycmp keycmp)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> =C2=A0	struct hfs_btree_header_rec *head;
> =C2=A0	struct address_space *mapping;
> +	struct hfs_bnode *node;
> =C2=A0	struct folio *folio;
> =C2=A0	struct buffer_head *bh;
> =C2=A0	unsigned int size;
> @@ -155,6 +202,19 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	kunmap_local(head);
> =C2=A0	folio_unlock(folio);
> =C2=A0	folio_put(folio);
> +
> +	node =3D hfs_bnode_find(tree, 0);
> +	if (IS_ERR(node))
> +		goto free_inode;
> +
> +	if (!hfs_bmap_test_bit(node, 0)) {
> +		pr_warn("(%s): %s (cnid 0x%x) map record invalid or
> bitmap corruption detected, forcing read-only.\n",
> +			sb->s_id, hfs_btree_name(id), id);
> +		pr_warn("Run fsck.hfs to repair.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
> +	hfs_bnode_put(node);
> =C2=A0	return tree;
> =C2=A0
> =C2=A0fail_folio:

Sorry, but this patch [1] already has implemented this functionality.
And this patch is in HFS/HFS+ tree (for-next branch).

Thanks,
Slava.

[1]
https://lore.kernel.org/r/20260716074150.1660-1-aditya.ansh182@gmail.com
