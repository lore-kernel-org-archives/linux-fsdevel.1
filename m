Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E93A381D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937269; cv=none; b=P1CqSPnIhx1FkdiX4EREgyxmmF0U9O5cjvfTQoWCs8gHXciHU6CKS3REEYWqVMQyoycu6lxzHCbJwzAa092i20lUw5YRLd5BU6xOyTl+z8ywSdCAMOJmBFBl5NuKD3Hu6RWDeP9vJUq2FWvmHzJUIXuftcCEAkbKl6ZqWc3f4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937269; c=relaxed/simple;
	bh=X/Ts6FB29sipVCHkAJKOzqHUgYArmLo5X/jhFL+PcWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KiesTBM+oPx61mPVel+A0pZuKgQis6RFT64UV4bI+1+IPS6RgtSGJZksuk+6qSHw0GTQ4UO/1QLCZifk6ss0T6CIXUPXjtv8rUqkJr8gJl8GyInj0xZNTUp/UtuSQwkEEpyqunh4bIiKKE9dTDLxt+2WY9jRbP/X/vPLgBWBKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSAan5pq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ojji7bUe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSAan5pq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ojji7bUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777937267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeaz/dAuRpUt7GzZUrHflLMUXhh07epuZ/gDSiDt6lQ=;
	b=dSAan5pq9MznOUv34k3k0ElDqiHM35mDaL+c+NygKw93p6erDDgHmv4U5jhbQUajddQDrd
	rpqQqv+rFtQdVvBmgpxnMj+m+v52xoJDPbohFLvD0MjYKtljwWGm9ZlL5/nVC/t7YppW7l
	gh1dxPmiFqVohjIa4KGORz1w4gnaHSw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-kBs_pEK6Nj6gyxEACcS45Q-1; Mon, 04 May 2026 19:27:44 -0400
X-MC-Unique: kBs_pEK6Nj6gyxEACcS45Q-1
X-Mimecast-MFC-AGG-ID: kBs_pEK6Nj6gyxEACcS45Q_1777937263
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd8cb25544so34009857b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777937263; x=1778542063; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yeaz/dAuRpUt7GzZUrHflLMUXhh07epuZ/gDSiDt6lQ=;
        b=Ojji7bUePPVSPBfvDnMUirWa6/C7s2ioCP9taSRHZ8avF93GgLTPKeBOMZEQqTaEeT
         DMFKUy2I0u0Fb8IRz8fMY6WWBJgpRGPLWxild76F6fAjwiaOCYZdByvq10sB3VsJzeON
         nKS5Uuc1kxVruG0OH/L+9Tm5tCcfaLxrxr1ITGYGIU5vEXE2U0NKrvwbPc3ZvB5sZWHm
         MP7+Fr7TuC9kP0nmAVN9Hvng/fuR9f0s6p3HkYch3GtlTpmg6aAMRGfm3G+YS0Aqxbo+
         nQxpcx2gU/eXXtu8gf7eymLn1HYI7WJJ75iX1qTlfu/cK6i5tXxrA0M3EozoCOos2V4n
         y7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777937263; x=1778542063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeaz/dAuRpUt7GzZUrHflLMUXhh07epuZ/gDSiDt6lQ=;
        b=bnWUf9YpUWZMfx6Dkr86u2y5HffNRQjrGx+HW4FiocfmT4lCBsezP31D/QKl9WEHPm
         xDmM6uggxdbepBmLaCOukpFOTtHrW9HgAZdp2Fb5WO60uFFX9Z/w5u8gepUYSM24n3Pk
         ndxeU7DjDSv78CdZkPCpa9zkMw5LEkkg0QOAlmsX0LT275D4AXNP9MxjDUZ6+PiK24lD
         eMqFtkzZMm53jWv3zVbg7bipVU+YyDVv5tbx3e0h7r4Yqscp2z1dqk9zJnLlEAEBFBj9
         nLfps0gWXdb1dmWu/j4gyRtN17UkundQPK1fI38Z8q9v03kwVHpOHIbbMdM/SWPN07GL
         aUXw==
X-Gm-Message-State: AOJu0YzCvGNDCNh/446GWqwpdRC4m3JHU6eNaUA1Ee2LRHtgToLFV6Ma
	ku1svQSLB+e3QYDQafcWsl0nWg86anB85JJ/V4qB/hW/rhN/xdOoneRIzkOAUDNW45UCqG2jTNB
	URi2L3wPgWOFANu8SeITB0dgyqlAcetS5tg5rbYRDysFsYDBVjTWQydCt1KjE1DaTc9k=
X-Gm-Gg: AeBDieuK9lhf+vBp653LXxztlfY5+ARj3kLD+AhFAm6zoVT8uvTJrtkCrfCkVlrHxUZ
	Zy2Kn6CyCrxRM1rAvQjztjQk8whL02CdCfVaxiesgR/BdKBeolJGloAsqciMwj9oeGZj4Fp3bqq
	zmrd6Binc2m/oJBvAic6MFqe+LXVfpzdMgq5l4zVG5IcFau5KUmxOg+xQ26Z5R+FBnywrAi5/G2
	cN1KozQxk7b+FOzeanu+VsgKVt4xXJHhTco0XSCSr1qv3maTcbn6TQRLm7zhbrO5oQDaUfZ7e7T
	kezlWywiDcFVUQVMnA6VlKaW6Cwn09tRziDEqUjJjw3GS96kK5xq41OUipakYyK0JREsKue0+1A
	WDVS3N796O60es3ldW1tSlyzHDetlw13Rmi7gbAG+5AqMtZaBcaWKRsIzPz35/6Q=
X-Received: by 2002:a05:690c:dd5:b0:7bd:882a:43e0 with SMTP id 00721157ae682-7bdac599075mr9047087b3.27.1777937263358;
        Mon, 04 May 2026 16:27:43 -0700 (PDT)
X-Received: by 2002:a05:690c:dd5:b0:7bd:882a:43e0 with SMTP id 00721157ae682-7bdac599075mr9046887b3.27.1777937262923;
        Mon, 04 May 2026 16:27:42 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652dae3sm55907087b3.8.2026.05.04.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:27:42 -0700 (PDT)
Message-ID: <2a12f80d489dbf0a5a128294a95e9181e607a5db.camel@redhat.com>
Subject: Re: [PATCH 1/3] hfs/hfsplus: fix u32 overflow in
 check_and_correct_requested_length
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com, 
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Date: Mon, 04 May 2026 16:27:40 -0700
In-Reply-To: <20260501110218.29906-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-01 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> check_and_correct_requested_length() compares (off + len) against
> node_size using u32 arithmetic.  When the caller passes a large len
> value (e.g. from an underflowed subtraction in hfs_brec_remove()),
> off + len can wrap past 2^32 and produce a small result, causing the
> bounds check to pass when it should fail.
>=20
> For example, with off=3D14 and len=3D0xFFFFFFF2 (underflowed from
> data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
> which is less than a typical node_size of 512, so the check passes and
> the subsequent memmove reads ~4GB past the node buffer.
>=20
> Fix this by comparing len against (node_size - off) instead.  Since
> is_bnode_offset_valid() already guarantees off < node_size before this
> point, the subtraction cannot underflow.
>=20
> Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6df204b70bf3261691c5
> Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
> Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De76bf3d19b85350571ac
> Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
> Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c          | 2 +-
>  fs/hfsplus/hfsplus_fs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 13d58c51fc46b..c00645a4a5733 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode=
 *node, u32 off, u32 len)
> =20
>  	node_size =3D node->tree->node_size;
> =20
> -	if ((off + len) > node_size) {
> +	if (len > node_size - off) {

I don't agree with likewise change. Probably, we need to have:

(u64)off + len

Thanks,
Slava.

>  		u32 new_len =3D node_size - off;
> =20
>  		pr_err("requested length has been corrected: "
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 3545b8dbf11c5..10b2dda3f8044 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bno=
de *node, u32 off, u32 len)
> =20
>  	node_size =3D node->tree->node_size;
> =20
> -	if ((off + len) > node_size) {
> +	if (len > node_size - off) {
>  		u32 new_len =3D node_size - off;
> =20
>  		pr_err("requested length has been corrected: "

