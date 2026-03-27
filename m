Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B2126C03
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648688; cv=none; b=WR/NUC2puEGVB3tfhhHUCjpQP3n6xGgu/YB3T3pXPhdGMrLjXT9kliw+Ee5NnrRNsx652OLM2nxqcUAZkTph8NTCuCrEMmFkxqer2HxypQOQW1Ge31qsCUDLr0Ybp52IJSzykX6LeEJ5pjiaYVjpDP8VnElBaNuLXdSzU3Rs4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648688; c=relaxed/simple;
	bh=LzATXYW+mc/fuACZ24wTN4X7oF3qEGacyYCW+C4ZrHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbv9dhr1mUN8KsUuIA4xhWybJDPTT9yC/gf5DEadnnvFDqcc+kxwrYiyDhsMYjLwcYopoP6RjfzjpvL5H5L5a109bAtMBkv/wtlqBPTT3jRCuoFktuHwqNc/C7Er4283aWXuLnYsawMYuxQgALqaua+3OqMI/qD4Oeb0vmQzvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9djB8Bf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HetAz8TU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9djB8Bf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HetAz8TU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774648685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHVrz8aem6/a6o9MtVoEU9Cw1uMMvnBHVyohXKaBn3k=;
	b=c9djB8BfQwCnJ03IWXdPSsI8LUIxboNWrg9kgyQcrtImM/82SIqo0vQr5YWxuqsvBHp/G8
	vawAz8OEBM4N62v/aMCBQ6cKMMa57hl9NH0+6pzEsZBb6vuYyEjVuSTUy+nnn1CzBdupHk
	829QhCPY7Rzh4Wcgcoyy43ADW/Uxv/s=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-NkLoe3BbOTaWVGSWjOpktg-1; Fri, 27 Mar 2026 17:58:04 -0400
X-MC-Unique: NkLoe3BbOTaWVGSWjOpktg-1
X-Mimecast-MFC-AGG-ID: NkLoe3BbOTaWVGSWjOpktg_1774648684
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65003042cf0so1513322d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774648684; x=1775253484; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XHVrz8aem6/a6o9MtVoEU9Cw1uMMvnBHVyohXKaBn3k=;
        b=HetAz8TUKfSX03MpBhTu836y1cCV2Bcis11wt6KjbKXZ8N+Z3j3IU6sNYI4aB3oy82
         MeOBOMeiM5mPmqE1n9AGxcA4ROBZMpS+r4td6sS6kTevat1bAvOeLyjahsx3VUCbIQv1
         n+CxcKkMbAr3Wg6IS66p//bw+8OLJPZZccd0uRMDJZItmYgdBdMEI2glednMXpJSoZod
         mKg82CsdudfmH/Y7GbOG401TmoMu9hnrdiAwUYo+xVIsRyhNel/5/hYWTAhBsQBNADyL
         8kBw7wtcr2FLig6KF4etRODN2ZHUYg44x+tfzrIKmbo7CXgK067tE3RnwqvVO+rJmtFo
         lvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774648684; x=1775253484;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHVrz8aem6/a6o9MtVoEU9Cw1uMMvnBHVyohXKaBn3k=;
        b=YdMEno53NXnGRBMN/wu4VRzO6yxIAGCLdWCChjDCvnClp3oY6GgwEsQsIV0eQFKC50
         Ey9GujpGgp1RXpsJiUzX2v9w0SQdJ05m6KXtYQSxPi8iXDCh1KLRAyRrB5vXi9rCcGaq
         2JmPBZAa9tDTZ6Bl45uNfRY7aPxa6usr4NgSJkylrf7+bBhxzv1+qS2+rQe+xPpkv69J
         xfdZjVKi2QN2A5yyV5JDAFqtyWnZj8AVi0h0jcL6Y2gnPRuo2VBcmGHljdBg9V5ij6kU
         yhZ5OqzCIiwEAizyJlk/IaMiIWg7ZsdIYUBbWkjsygMRP9njZBR7Am9JyL9zEtli592e
         rJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbZAgYuN5c6mSKlKXgV8f0oVqWohHP9lahbBE9W4U2gP3ktuHkXw+aC3ov0HOETQ4W1KC/4dlp4/WKmE48@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6FywCXU/VvdrZtxaNeEqc6gMcXWQ2OGnbs+jWKfNgslib7YY
	tzGxMbMJT2lMH6oKSNVyRjpN9E5wictRIlo0BcR9OgH4EbuoesAbsGfWmQb+oIUnJPaTxJWQLXW
	wh3Cwijh8p0t0K7Dh5DGy97oIAxpeck1mTbytzvuUWGDoy0KuGxjv18UyyBQxJeegddU=
X-Gm-Gg: ATEYQzwYSbfpunLAsdVmDgRNSSoAjem6cefPtb3cUQ2Z9Y9SzJaDxAqFk6RijHuqwMj
	IYYpL59+cvQcCL99XIUef267k7AgFwQmKK1aZZ1ChwIZ+OVNpbrBFiaflQzrago5MLdAfjiUyJB
	r69+w6sNBiNUr9FqXM6s7HM1rl/z1Q4gGEtQQRE8GSDAxiXWKV289RerdKSEZSB+wACSr/Ig9Ii
	dl2JgbwFpvSaoOKietbxHujJ9GrcsqRWSKsC9Irjl+OAmSc8CrZ+eORxBF1YoGcAT/QxZOa2jTg
	PRZNRtlhwbpU2E46LY/BEQJxjxQf1ZL3djAvpnZLM1BOm0FnTjQrZ/kCr589JmIonXOFeObXX2o
	gH6Qb0NDsy01agNqFJIp36BFM1Win8GZlWE9aeZP6MYJvtIo40tEA
X-Received: by 2002:a05:690c:6d84:b0:79a:57a2:ed75 with SMTP id 00721157ae682-79bde0105e3mr44985037b3.34.1774648683651;
        Fri, 27 Mar 2026 14:58:03 -0700 (PDT)
X-Received: by 2002:a05:690c:6d84:b0:79a:57a2:ed75 with SMTP id 00721157ae682-79bde0105e3mr44984807b3.34.1774648683219;
        Fri, 27 Mar 2026 14:58:03 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cba95b868sm1227907b3.45.2026.03.27.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 14:58:02 -0700 (PDT)
Message-ID: <b5efea03a044228464faee0aebc7d38386b56789.camel@redhat.com>
Subject: Re: [PATCH 02/10] ceph: add bounded timeout and diagnostics to
 wait_caps_flush()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Fri, 27 Mar 2026 14:58:00 -0700
In-Reply-To: <20260327143045.1393612-3-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
	 <20260327143045.1393612-3-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 14:30 +0000, Alex Markuze wrote:
> Convert wait_caps_flush() from an unbounded wait into a bounded loop that
> periodically dumps outstanding flush state when progress stalls. This
> preserves the original data-integrity semantics while making hung cap
> flushes diagnosable during reset development and validation.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/caps.c       |  7 +++++++
>  fs/ceph/mds_client.c | 47 ++++++++++++++++++++++++++++++++++++++++++--
>  fs/ceph/super.h      |  2 ++
>  3 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index d51454e995a8..be030fb8e864 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1648,6 +1648,7 @@ static void __ceph_flush_snaps(struct ceph_inode_in=
fo *ci,
> =20
>  		spin_lock(&mdsc->cap_dirty_lock);
>  		capsnap->cap_flush.tid =3D ++mdsc->last_cap_flush_tid;
> +		capsnap->cap_flush.ci =3D ci;
>  		list_add_tail(&capsnap->cap_flush.g_list,
>  			      &mdsc->cap_flush_list);
>  		if (oldest_flush_tid =3D=3D 0)
> @@ -1846,6 +1847,9 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
>  		return NULL;
> =20
>  	cf->is_capsnap =3D false;
> +	cf->ci =3D NULL;
> +	cf->tid =3D 0;
> +	cf->wake =3D false;

It looks like cf->caps needs initialization too. Am I correct?
The dump_cap_flushes() unconditionally calls ceph_cap_string(cf->caps).

>  	return cf;
>  }
> =20
> @@ -1931,6 +1935,7 @@ static u64 __mark_caps_flushing(struct inode *inode=
,
>  	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
> =20
>  	swap(cf, ci->i_prealloc_cap_flush);
> +	cf->ci =3D ci;
>  	cf->caps =3D flushing;
>  	cf->wake =3D wake;
> =20
> @@ -3826,6 +3831,8 @@ static void handle_cap_flush_ack(struct inode *inod=
e, u64 flush_tid,
>  	bool wake_ci =3D false;
>  	bool wake_mdsc =3D false;
> =20
> +	ci->i_last_cap_flush_ack =3D flush_tid;

Do we have race condition here with dump_cap_flushes()? Maybe,
READ_ONCE/WRITE_ONCE pair make sense?

> +
>  	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
>  		/* Is this the one that was flushed? */
>  		if (cf->tid =3D=3D flush_tid)
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 12f1b57d4b1c..d70c0b669b75 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -27,6 +27,8 @@
>  #include <trace/events/ceph.h>
> =20
>  #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
> +#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
> +#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
> =20
>  /*
>   * A cluster of MDS (metadata server) daemons is responsible for
> @@ -2285,6 +2287,40 @@ static int check_caps_flush(struct ceph_mds_client=
 *mdsc,
>  	return ret;
>  }
> =20
> +/*
> + * Dump pending cap flushes for diagnostic purposes.
> + *
> + * cf->ci is safe to dereference here: the inode remains alive while its
> + * ceph_cap_flush is on i_cap_flush_list, which holds a reference.
> + */
> +static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
> +{
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	struct ceph_cap_flush *cf;
> +
> +	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
> +		       want_tid);
> +	spin_lock(&mdsc->cap_dirty_lock);
> +	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {

So, what's about inode lifetime here? The iteration is over the global
cap_flush_list (via g_list), not i_cap_flush_list. Are we safe here?

> +		if (cf->tid > want_tid)
> +			break;
> +		if (!cf->ci) {
> +			pr_info_client(cl,
> +				       "(null ci) %s tid=3D%llu wake=3D%d%s\n",
> +				       ceph_cap_string(cf->caps), cf->tid,
> +				       cf->wake,
> +				       cf->is_capsnap ? " is_capsnap" : "");
> +			continue;
> +		}
> +		pr_info_client(cl, "%llx:%llx %s %llu %llu %d%s\n",
> +			       ceph_vinop(&cf->ci->netfs.inode),
> +			       ceph_cap_string(cf->caps), cf->tid,
> +			       cf->ci->i_last_cap_flush_ack, cf->wake,
> +			       cf->is_capsnap ? " is_capsnap" : "");
> +	}
> +	spin_unlock(&mdsc->cap_dirty_lock);
> +}
> +
>  /*
>   * flush all dirty inode data to disk.
>   *
> @@ -2294,11 +2330,18 @@ static void wait_caps_flush(struct ceph_mds_clien=
t *mdsc,
>  			    u64 want_flush_tid)
>  {
>  	struct ceph_client *cl =3D mdsc->fsc->client;
> +	int i =3D 0;
> +	long ret;
> =20
>  	doutc(cl, "want %llu\n", want_flush_tid);
> =20
> -	wait_event(mdsc->cap_flushing_wq,
> -		   check_caps_flush(mdsc, want_flush_tid));
> +	do {
> +		ret =3D wait_event_timeout(mdsc->cap_flushing_wq,
> +			   check_caps_flush(mdsc, want_flush_tid),
> +			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
> +		if (ret =3D=3D 0 && i++ < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
> +			dump_cap_flushes(mdsc, want_flush_tid);
> +	} while (ret =3D=3D 0);
> =20
>  	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
>  }
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 272c287836c1..5de1e5923b63 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -238,6 +238,7 @@ struct ceph_cap_flush {
>  	bool is_capsnap; /* true means capsnap */
>  	struct list_head g_list; // global
>  	struct list_head i_list; // per inode
> +	struct ceph_inode_info *ci;
>  };
> =20
>  /*
> @@ -443,6 +444,7 @@ struct ceph_inode_info {
>  	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 o=
r
>  						    dirty|flushing caps */
>  	unsigned i_snap_caps;           /* cap bits for snapped files */
> +	u64 i_last_cap_flush_ack;		/* latest cap flush_ack tid for this inode *=
/

It looks like i_last_cap_flush_ack is not initialized properly anywhere.

Thanks,
Slava.

> =20
>  	unsigned long i_last_rd;
>  	unsigned long i_last_wr;

