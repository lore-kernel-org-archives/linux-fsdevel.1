Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37293C2BA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744519; cv=none; b=VRqMM2LjZh2VOcn45ZWxVViSET5cXX0UIc6t34P4cMG8038pTR0zE+fEXpRlsqM+n/to7SK+Ly8w/11cbyEzm7bx9Cnw5w3UrBIA7wLHePc1leaG/ocDjuHDVFwo8LfJqMGqpV7zp7K4zeVgy/Vz9P+woxQaI6jbocKAevlHlnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744519; c=relaxed/simple;
	bh=4YTsK+6/l/CkLc8rGb8E7sQlnIsM5FCCNDJ9bwMcBlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hm7OfCB/olCw84AHoo4RtGWiYNQ/iQiUMGvij9XozFMTge1Au/MOAY5Cs+t1frpBYV+UFUdxTP48BrUgllwgITEtuO5vKUIoVZIKVSfUhBep9lNXSB2F7UmJeCXp7S2O8gt3rMhdsFy9SxzjZArbou2DXzybkyVL7S094qwa2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsNghSzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsNghSzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844551F000E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787744517;
	bh=l5gYCs4oSFcIoS+GW8OvPSZeGHFgRcx9P9U782wyTvM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NsNghSzRAJCy+xqsxabiYFTkD81i3U3/Vjt5y6IwxOXTCJpHtTX2DhPOG3hqlQrQF
	 ZLGWrBmSfDTpq1Jrvxp7tKPP6x0QS3F+ixtl/6dvJPRNe+AMJUUbJsG8t5pIGC8JzE
	 okeiUBJ96WxSnDA6zfO/vr73Sxu/biGVr3CqOovelib+lFoqOlGPiKy/jVGW4Ct1gP
	 wPbqRLuGLrvUsrRoa5DzDR3r/lNwkIgaApdRQFO2TT+zMKUhJSDEI5UtmPCKxC3u83
	 Nr7M+bMCEOmmcUtunv73N0uBy0O+azLXA5qkUgtkrMfoxuXt2mTCIEZv9N3qVvbaOB
	 eF6CUc9W7EdeA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1577766a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 04:41:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoMOvBa4D/s67OSU1OPm9MKjYapW+hKpjZQrNTawkSAWkAHs0FOKWcoQsNbkv2zUgSi93BgRoFaeovjqEdV@vger.kernel.org
X-Gm-Message-State: AFuF++nHo0cZj/8APPni/cau004oed8aVcibPmihNBed+hPrHhTchNDv
	h7HsS/gSu3+18AB+9bOC7XuTdj2y0uPgqEYAAEPUojWh+hQtk4FIyWBseYI3V/PDRnH3Zn4lGAq
	W55O3G51qt+KREfYPbw0TWMfyTIakBdY=
X-Received: by 2002:a05:6402:52c9:b0:6a3:691a:9d71 with SMTP id
 4fb4d7f45d1cf-6a5df634223mr8254241a12.11.1787744516231; Wed, 26 Aug 2026
 04:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a8e7511.9e2d85f8.1d4e3b.c404@mx.google.com>
In-Reply-To: <6a8e7511.9e2d85f8.1d4e3b.c404@mx.google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 26 Aug 2026 20:41:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8YDpTrru8aB343K-22hReS3_Hqa3JuEbxumaMPdLetTA@mail.gmail.com>
X-Gm-Features: AcwNN1U_KbOwSfPU0N6OCKpuyhQA8Sim5a19VlQTmN35qEeWxyzD65D-00zXAbc
Message-ID: <CAKYAXd8YDpTrru8aB343K-22hReS3_Hqa3JuEbxumaMPdLetTA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: reject invalid sectors_per_cluster in the boot sector
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:09=E2=80=AFPM Dennis Tighe <dennis.tighe@gmail.co=
m> wrote:
>
> is_boot_sector_ntfs() checks the boot sector's sectors_per_cluster field
> with a range test that rejects 0x81..0xf3 but accepts 0 and other
> non-power-of-two counts. A zero value reaches parse_ntfs_boot_sector():
>
>         sectors_per_cluster_bits =3D ffs(sectors_per_cluster) - 1;
>         ...
>         vol->cluster_size =3D vol->sector_size << sectors_per_cluster_bit=
s;
>
> ffs(0) is 0, so sectors_per_cluster_bits becomes (unsigned)-1 and the
> shift is undefined:
>
>   UBSAN: shift-out-of-bounds in fs/ntfs/super.c:673:39
>   shift exponent 4294967295 is too large for 32-bit type 'int'
>
> This change rejects any non-power-of-two value, since it feeds the
> aforementioned shift via ffs() - 1, which only yields the correct shift f=
or a
> power of two.
>
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
Applied it to #ntfs-next.
Thanks!
