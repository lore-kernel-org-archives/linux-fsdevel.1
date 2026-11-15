Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794756135;
	b=y4Hrmj3bUx5i7ZdXPsOY+X0Ipv4OXn89ae49Pfm7rOz/DefkZnFEnt7zj5zPi2zbAuk5
	 uBAwErCO08WwfnMvgWcu/B9Ef2IgAdO3ek1T2n8OMBpkzLj6GYJwwj0+Zl/2JggIQMJbA
	 np0EEUY/noiW5kOKd64rClq55Hg3wniqIX3qglymApopkY+W+aCGxiy2OyfQb2i7XyGy4
	 qQiKLsYtMm5Xigde9ihQc+CApfNWiG9dMd5cDpTAohYxbe1UQMSAVQtN8mE8R6JCAT1J8
	 ND9+FrlXGa13F4IHiRp90/9BLjnHbf+4IkQuiiyL7tNCBMTrF5cymOMRPLTZpMxg+cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GxReng+XnewRESsKu6uChjYEUW/6PlKiULfwq5871Ek=;
	b=E020/G6p/h6BXZNT6CbiTNQeDgwRJARijwSiG5oBbSlmK4xagSA1la6rvQGnh4k1hqfo
	 n65+U1myN5Gn2fDE+GU7th+YEZthileo+LfGS4wJbwzcN2R/7eXr6v6uDMrIgseKzmNgS
	 2oxIth4G+p2YdbzHOHXEJarEb2H+fUIY7h1CxgfiKLScrgrkl9FXWTLUFpuHHjGvxuJZE
	 Gk+ahqX1tifurbfgd9E9j4jM2OYRQPdrAppCeJlAP8dlNtNgKjHBpSX6vjg0y+T8CXBbt
	 0VkofIDT+jd/LTVWBkMuvF1Hkn4PINtTvC9w2cdJZnoSbdxXn+bwG53ecUDs0Rq64NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj6pR5l4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14677606A31D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 15:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14677606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oj6pR5l4
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b7efd3bc26so892619a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 07:22:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794756133; cv=none;
        d=google.com; s=arc-20260327;
        b=L1+pY58e4L9DwUPekZV/oTvdKY2Xe8+Oxz7vKpbcma1byqI8/fTAxRQkpMb3aKVm0V
         23EPlSEXdAJtLRarvX6pk8Ljb//i4XC47ZIBhufUT+cKdWEbMNZn3RqKn7GH4HPqKTFe
         uaNW0YEx7BVxbgYv6/v6bH0PrvR+xMFbB3eVmqigG/Qq36TmNBCbKaSsivQ/As1aZzBy
         kWxhfPVl4eMMaR5ELs/8r3pF6q02fLNOwTCF+MMZVg9Mix4rKU8amySFJuoFeqOiNfA2
         OP8OzpqSAJS1IAU4ot39MWqjefv8vGRxUtxR2VNxSB5r7CR9/53XE89alvYvHL2e4ZnJ
         aC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GxReng+XnewRESsKu6uChjYEUW/6PlKiULfwq5871Ek=;
        fh=hcq6KTnAH+YqwJAuNiKn903RMYspkFFgrbpMHUNnemg=;
        b=hN6uITAtzAM9nB9p4HGp2ciLnJCAukN+cSJI+PDtaCK3E7sRBN9hb369npzDGsooOx
         v+pgB1zXrKsVrywhu5JV2em7cqeKi0/hjA2z3v5qRH2s5RemT1UxxeF960Jd1QXCMrR1
         4TVRf3Lb34dhYXlEo1vffv77TYNbmbUcsPYXVH+MDEJ3zvOidqjwJ6TiP0I0Sozimm6C
         xiwP6RUCPEmFuSI9JD4MNlXVs9VcUp4a4Dw24/+rPaS8cq123SBA0wBuxSmV0p08AUy6
         Lu6ydKKeCKXigOumTv5Sn4DelQZxjiLcIAoIC4BWBgP5qk9HWEA1bSJ4cm0CV0vSS6cE
         BB/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794756133; x=1795360933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GxReng+XnewRESsKu6uChjYEUW/6PlKiULfwq5871Ek=;
        b=oj6pR5l4SMufFin6zAMGvHQ7xlZxyUlA0LeLggXOd6/fG0VmxnhbNK7SKjQmGkCXbh
         AaOhwQSfZRIEzylAMOCAwRTWzgJluWptQZzoLTTzpbAyohQO/EElVJEK4ai00NQDMu9c
         W1qDOZnuWh3Iz0fknpxIwbei49qf19v8ZsswmLiSh1aWaj76Rg8X/xkGb5VGCNIriUWj
         4ctfMjinPt0LyNGGPBkeGpzaS0HPKwZ2jyDuwAM01NNm173HpvSZ7ppDc7zVkIUZrMwX
         biehFONVgFw7Ur2fDiRAQi4cjCZX/7jRRO6RkTcwqxeXB6t0s24LXlu/NhI+PKQ14zpq
         VboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794756133; x=1795360933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GxReng+XnewRESsKu6uChjYEUW/6PlKiULfwq5871Ek=;
        b=0CSW+oWeuQeuZ2H6MVGETKE70rvPV1KYLyBAAU88Q7R+rxeiWceFLo392Hkrb3b18l
         HBROVXyDV9C7P6kd37Mf9zjHWNR71PFhzcayNFY0zNCF3Pb0N9RTCKRXzEywEPvDN/V/
         /obqo5w7oa0Dzu54t5qoCvnsbzNeZwllRu4kz1CECYi0mXyMDzrPO9IAKtvj2eGWz7N1
         zA4pWWCYgGYibwrjtlWeCxW3V2Jeda7F9qqpWEPxzzljmAnn47wYrOa8+CGvZaDqGATA
         tq2SVpKsV9uCFth3BvYdRu1Pwat8xZNDhhLv6ckBT0w22pECt/YZgGjfBmUALdMStDlj
         myHg==
X-Forwarded-Encrypted: i=1; AL+hErG9fI7aE6YDUMYaLQMf5atuHwoCN2mbwrovANNuO+GIDtfqjkxSl+2mi2aVjb5n70OkPpsr8gTDG+M4tDg/@vger.kernel.org
X-Gm-Message-State: APuU4Z+RHc6FdZ8fb9/X/CECd3Snh5RC0Yy6RUV7Ab65YQlgaHidxjL7
	S5q/j/80Q54ipdx/wnX0k8Kcj8FFN95Y7ORpxZoSGc36J71SwsULUVIUk0OFj0tRIPT553ZM68R
	lkaXW1eENGWwc+r+PiIMI1eIZAVDSNg84gQh8r/s=
X-Gm-Gg: AYBFou2UU1cNyQverAbHZP9eEOoyGKpEE6gVPMchlcRTwk0b6wRjBAPhybOdjjvphdJ
	l2hi7jzhxhYhPe8ljdTMOWnjjkhSMk4r14zPK6RgubHSjHdsPkcUKnG6mmdOLGHplFxo5BAqPtb
	RNFxreUNgykNP6jQMZGSqeoN3IROlTPlR2TdHqbfWL94gSk8Qf/Gyn/DmcXe5ztIum7Hq7KKzO8
	29lZKO6+JJ7KpZ+9smsg3uwLWkXStT4e6/MKiA0ERDU1K50Jiy4wtLl8EljFl0pPy5WV5LbbTmq
	2nI68JY5heH4J6JscstHaaocOt9b5mxmYOoSC0iEkFMjaPmbZft7BFvhQIh5GGVlqNjNMN94RNs
	xJN1ji7FacUN0gJSxuoR5qeyEOJJ7HlEWE2BwVX9678KIMfBGb8YvMZoX4oFLxHPD/oGgvw==
X-Received: by 2002:aa7:d94d:0:b0:6b6:ef7f:600d with SMTP id
 4fb4d7f45d1cf-6b7c0bdfeb9mr4462746a12.21.1794756133149; Sun, 15 Nov 2026
 07:22:13 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015143601.2095784-1-amir73il@gmail.com> <20261015143601.2095784-12-amir73il@gmail.com>
In-Reply-To: <20261015143601.2095784-12-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:22:02 +0100
X-Gm-Features: AclHuK-h6HJEUJrhmV8qd_gWx8L3BkPYf6Id19Mi9ToN34b9lyD1DAKwgUrzWZE
Message-ID: <CAOQ4uxjHXb7FteUaesEf-dFHsdw-qsobNkZOvYqTq-6wLeE1Bw@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] fanotify: introduce FAN_EVENT_MATCH() macro
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:36=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> With "strong typed" events a correctly written program needs to
> use the new macros FAN_EVENT_MATCH() FAN_EVENT_MASK_MATCH() to match
> the reported event mask in the scope of the watcher type.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/uapi/linux/fanotify.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 0744b6770b43d..1f9a33d21c03d 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -14,6 +14,11 @@
>  #define FAN_EVENT_TYPE(mask)   \
>         (((mask) & FAN_EVENT_TYPE_MASK) >> FAN_EVENT_TYPE_SHIFT)
>
> +/* Match event mask to any event in @event_set of the same watcher type =
*/
> +#define FAN_EVENT_MASK_MATCH(mask, event_set)                  \
> +       (FAN_EVENT_TYPE(mask) =3D=3D FAN_EVENT_TYPE(event_set) &&   \
> +        ((mask) & (event_set) & ~FAN_EVENT_TYPE_MASK))
> +
>  /*
>   * Events that user-space can request when watching filesystems
>   */
> @@ -296,4 +301,8 @@ struct fanotify_response_info_audit_rule {
>                                 (long)(meta)->event_len >=3D (long)FAN_EV=
ENT_METADATA_LEN && \
>                                 (long)(meta)->event_len <=3D (long)(len))
>
> +/* Was one of the events in @event_set reported in the event? */
> +#define FAN_EVENT_MATCH(meta, event_set)                       \
> +       FAN_EVENT_MASK_MATCH((meta)->mask, event_set)
> +

FYI, I realized that a strong typed overflow event is wrong, so
I added:

#define FAN_EVENT_OVERFLOW(meta)        ((meta)->mask =3D=3D FAN_Q_OVERFLOW=
)

And made sure that:

    An event queue overflow is reported to groups of all watcher types
    without the watcher type bits, so the FAN_EVENT_OVERFLOW() macro can
    check for it on any group.

        metadata.mask =3D fanotify_group_outgoing_events(group, event->mask=
);
+       /* Report watcher type of events that are not common to all types *=
/
+       if (FAN_GROUP_FLAG(group, FANOTIFY_REPORT_TYPE) &&
+           metadata.mask & ~FANOTIFY_COMMON_EVENT_BITS)
+               metadata.mask |=3D (u64)group->type << FAN_EVENT_TYPE_SHIFT=
;

Pushed this to my github branch fsnotify_group_type

Thanks,
Amir.
