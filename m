Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F91DDFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406570; cv=none; b=d+q3GeAIClFo+5bJHIpNPMXFlLpf1gkO7QW6jA4RWJw8nu/yz/VM/nn2EEtdd9jsHy7or2NjT+bYwfTyaMQQLDhImvly4STb8LXXDrbj0ts5anDgH8sAw0qitszVT4TFdBY+Q9Red3j3Nd3NCD/gy2GvxfHTz71gj4KTtUxHN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406570; c=relaxed/simple;
	bh=rclWJlRfIPhuRSoZO9Q3ivcPzP8aL92uCdwLgc97HTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpkhCVWVS9kuRzy2OPWuPN42ZnP6o/OfHYd055Am4yNFpoZFnG9H8mh2f/EUo7dBcetOdVYZgRLm9r+UjPxtK7NpjjGkqwpfYtK+Rli5w/hPNxaNmt2k9QJjEyU50V2JrR7GzK+jFCB8AXWhzwHW6Dr7nWt2Ho5SmdySUeaFj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=troEIKFV; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="troEIKFV"
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-8200c88611eso15155837b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 17:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786406568; x=1787011368; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYiVcQ7n1Vw7jigeXWA7191Ayx/8beAKuU+DgnEvJHA=;
        b=troEIKFVv5YFbHXhIe8S07A+g62nETle5lzI7D6doMna7NG/M0HptGUU7Cfg9Ydk6u
         LU9WRIJSYUT3T2xYZ68cnMofM8eOpDdWysNHMCJV9Mo2J6nTu55Yd+7NqKb+5zDHzBIn
         eqcE1e9/EkQ9i21x50qMQBTmyEvxe3tR84IoJAB6Kk6I9QW4jYn5D3hAtvtu6+uKUeOP
         VIMqgst+GXbSYpaRCXhE9o4Pe/M69yXotS8SvnrUAlvUWIZ4QXuDnWucFFTeYAn8x8g2
         T4mTxj5SM9rlr3/XDNsOqZpfYkG2MgyseHWuJluCOpkm/1UG8GFgJoltEAexGJpY3HqB
         xpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406568; x=1787011368;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xYiVcQ7n1Vw7jigeXWA7191Ayx/8beAKuU+DgnEvJHA=;
        b=K5KHES2GOS4nhFQL9ldUWHrdtw4KixagPLkO9t3WQrXuvdEqIDOq0R8vgyBv+gH1h4
         IrtPvZnaNAS3AacQBGUNcaFJkS24oS2k8LIIwuFl8Y2l1o0fxt3Yf9AGjqinlRoQ9tDr
         hdgm4JgDxT2CoNEQ5+tG/dRnQCrsXrTuWOiTwUOfcWCXfhq5ofKe89HCwC1DNuUfjilS
         UQYVWbrMkGtDDnDUFnFnvKnCUX/RwUyMXKDWgAAJLXIqAfA9I6srr1XjXFBc460jG71j
         KRg0CtC4j7bITNHN8ki+wLYYgSWn1Zzs9rFdDxZqLOGFVuxg2pnU3Z+74+YWZMxbjsOb
         wzNw==
X-Forwarded-Encrypted: i=1; AHgh+RrtMyRnMPZ5vbm8d/TXq2HSeEbhJVQumUtIbIP4a+6u5EOVbiVoye8GGzwzunZlxjddVgTiz6IFbVTIafjo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/agSjAG4RnyCK+P7uz4HZ7VleKZovP2hNXzKS0VF1o70oAMuw
	xorPbCMHobGedjmcH+eLXrNgsq7gpB/+pNA9/3Bj4BgV/gNfbLeidVeWzyBE6518Clc=
X-Gm-Gg: AR+sD10W1woKyX5WayvFsAiQEoul19YXIOA40Dn9Aj9KjkGXKVn+lsZuSDJ7be8MuQZ
	WfuVgW1SF3LG1yZvB5vbYTRJVgMFEq7TNLT2yUs9NY8C7fxFKZDUrVOgvcJzoJQe2ZtoXmfHZ7w
	UVhv3xkVAta05wkxaTdhk9so3i6KHrACHzT7HRDdq/9Cg1j47BRtqhYiPD0WtRIKC4BaVy3GcO4
	j3UyelOx2laHTncQHrar1ZvF1VvcCdBV+g1evIkQQ7gVRdnSg1f8YYBQFtsnipXPDXYM1Qi9mc2
	Cp+AnO5+q/Nwp+biHeoCdtR+GHNFLQmhlPVEKRXUtv+g++idVswtelJH2awOUgr87YkrLObyBei
	I6MF1utGpjIe0vj8yoy9csjW+CEdCUDU8D31vPcJi43Vuljf5lzrTXGMAxqKnvseLkSYQAH4h+0
	XZOpSKq2j6Si5VrKMQfe9U0MehKZ16jhinJWi+zFgUDTrtMb32WuRlwFfUrigjHhV/arQqkscoU
	R5iTOpNgmYrkN+zH2lL9BB1yQKFh3neC4NQmN1fILHcNBqZMDVPWKcBIFBqdxsz4cA/I+DY2ACt
	oEqG9uDvUIhA6SN/H9K3KSSE4NYZoLt59evmGFyPVIKMKg+O
X-Received: by 2002:a05:690c:dd3:b0:80c:5ce9:8f1a with SMTP id 00721157ae682-82d2fe69775mr37849517b3.34.1786406567712;
        Mon, 10 Aug 2026 17:02:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9c3:cf0:a72e:f469? ([2600:1700:6476:1430:9c3:cf0:a72e:f469])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ebd0cda6asm245077b3.6.2026.08.10.17.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:02:46 -0700 (PDT)
Message-ID: <5f60c60a03b3d3e4b6d4adc2f241371b72977206.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: validate extent record length before writing
 it back
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, vdubeyko@coreweave.com
Date: Mon, 10 Aug 2026 17:02:43 -0700
In-Reply-To: <20260810092422.1691377-1-r772577952@gmail.com>
References: <0720c3ba6399c11a0a328e8d8eef99a19e6999c8.camel@dubeyko.com>
	 <20260810092422.1691377-1-r772577952@gmail.com>
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

On Mon, 2026-08-10 at 17:24 +0800, Jiaming Zhang wrote:
> __hfsplus_ext_write_extent() writes the cached extent record back
> into a
> B-tree node using fd->entrylength as the length, and fd->entrylength
> is
> derived in __hfs_brec_find() from two on-disk values:
>=20
> 	fd->entrylength =3D len - keylen;
>=20
> A crafted image can keep both len and keylen valid but make fd-
> >entrylength
> negative (keylen > len). __hfsplus_ext_write_extent() doesn't check
> fd->entrylength before consuming it, and hfs_bnode_write() takes the
> length
> as u32, so the negative value turns into a huge one. The copy then
> reads
> data past the end of hip->cached_extents, which is only
> sizeof(hfsplus_extent_rec) bytes long, and leaks kernel memory into
> the
> image.
>=20
> Reject an fd->entrylength that does not match
> sizeof(hfsplus_extent_rec) in
> __hfsplus_ext_write_extent(), mirroring the check already performed
> in
> __hfsplus_ext_read_extent().
>=20
> Link:
> https://lore.kernel.org/lkml/cbd7003314c530d4f910eacf019ff80adad6687e.cam=
el@dubeyko.com/
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> =C2=A0fs/hfsplus/extents.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index 813e68b8ecd6..eb7c11524d18 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -110,6 +110,8 @@ static int __hfsplus_ext_write_extent(struct
> inode *inode,
> =C2=A0	} else {
> =C2=A0		if (res)
> =C2=A0			return res;
> +		if (fd->entrylength !=3D sizeof(hfsplus_extent_rec))
> +			return -EIO;
> =C2=A0		hfs_bnode_write(fd->bnode, hip->cached_extents,
> =C2=A0				fd->entryoffset, fd->entrylength);
> =C2=A0		hip->extent_state &=3D ~HFSPLUS_EXT_DIRTY;

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
