Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793754880;
	b=qa7Q7gwpwNg+jXMO7q9Tupurr8Znw1J6OqBAEhNMhiiCROCHRn1RG3yqQKCoueHPTnJD
	 IsZn60cywZDjKgz8jKvIvipOZhfvU1GcVPcCyCt0oAU1XLYB+cYiuNCoAn0lWnKb09ucQ
	 3cepcz5TAGZpghAySXRZWsQRPOdVYqU+pG6zsIWuZ7b49ng4mKqJM9YAuzW1rKe+4b6a8
	 ior4KOUYRBDcpImbkbEooe4nyM1trPcYJI8Z0MrdrnuDs+CMr84nyW3S2ukh6ADHlsU5s
	 ptHyCGS7WsAIQClkdNtDUhT2ldkgy7o8C2bFh/PRrB9KFsfF/sENejhr6KvQ39wCqSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
	b=REZJW6lCSvgArhBMXOtYkdvn7pfVQkXVAnu71qrn/KZxn1I4se6hM87V4xZjn2n5QJvc
	 BGnwHk0XKBGZZEXeWelJJn57YXkCx8oIdYInq4qBytkEIcUw43mQvey1tzv6hi7KSJU2N
	 pkb/lfevmhH9IofEZk5KHuX7+kKSIW4ChfcKRPlGCr9IY1zG9gR8CVODRZ3lveLrZyPQF
	 dHkvq0bJWNA+MGXZ716QPc7ZSq6mvQ/Qk4rlRT2breRJ5bZ6nFZM/rA4UWupyBtgpli3h
	 yaqnwsPoOyAJBUHsd6g26oypYCN1vQOjSxhQnnhZyPVVJfneL1LdUWjwrakUj+fE+DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IR9x7CF7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E31606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 01:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E31606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IR9x7CF7
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso2008148a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 17:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793754879; cv=none;
        d=google.com; s=arc-20260327;
        b=b3YLusslUuoTu8Xdd0q+r3PuopzFku4ge7+6DgLPgYClywqlvA5G2KiIegCChsvA4w
         j/k9lkW4CD52LH/G+eZ6OeZZ7fVDWi7tyBNha4DsyzK30hVovNNJZudtHdOIqh8O8fWn
         /D5pRchwzZZunYGualrZCAIEEQEg+cU7DvGpgxuZVSh0bm7XsgF55y2exf+YQ83lBlBJ
         BPZYjy9i0igXAZxuNAwklckKGDmt6QGO7kHf9PARveeiTLqNAyGNIa9HMuewac1/2cu5
         RsU20ZMnmr7tcnAm8/RVTWTwrWzrARs+mbSRYugj8Ei/DDUZJZEASMVts/ohBuGrckC5
         A4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
        fh=1IwWzYA/0fGVwAI2lyAhhA4HZ/OCq9G8FAT27XD0TCk=;
        b=aowyA8i64i97RG0W5TvRgMbvf2SXlC8u+WB0JlCRMRm9msNFRHfNtlh+B2mh1Vrv0j
         u/x1cbDt7KzaISp0RYp03Ccqw5CrR+s+t5V88W8q8cXlmT47kfcZG2mldM59+ALH8ZHr
         7iXxepds15l74A7M706S8NrwfIrPOmXjgoze+DImrLhK2xWRvlXk2ty7/CxceQwno2mm
         7KRXNBfEanGiWjZmBOxDGI1cEQ7hOSejxKun2nSM2IlJkA05zOOTZq03rMQ0BavMITFf
         HI+ut6awgUM9ThoS7F2wY8KmtTRDIb4txRKwJ392CMfhh2uEwjnEQWb98vbPeAMa3c1w
         +VLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793754879; x=1794359679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
        b=IR9x7CF7c4Mx0rniIXPJTap8Sl2/dr9gnbELz6lBJ5PjaAf02D1YAm2LSs37v81qCo
         DJ71amOTkdnMI00EPyhPmP/6O+dR1fHBGhBB8N08HS6IJb3bavA83yLJPIT5q1bmVYfO
         U9I8Mv1AhAISD9gQHYCQU9CqQs9uRSuFf/GBXxNes4jOmAx8FJ1/EC6+PRLfHwtyJlGh
         4bs/oRUDp3W+5e0rZ33XgLzI9zfcEnyXv3UPZwfkyHp9gepUycTy312afEDxLJBu+uDY
         JrNO004oX9+ApUMczZEAcZ/liFPBCKXYAxWJ3CGOVdhpd9Rcsvf05tTRbO/lhbaNTijb
         aS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754879; x=1794359679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
        b=dCK78qCImYjvtv10K89JAsvXEyIdnQ4lWtjoHZDjYjmRQxqEQ+5UmkUUluHFiTWB2i
         lt4UzNdVEoei6QtWh1mzfasS3EQa1r6Z5x8dVB7XW/cCuGybOlRxfYf26tz7wfUwexDt
         DRMO6G23gVRvfHCVKOEAchBAB9vkvOUNjz01Sv1Wr73Izr/qOm4fSbewA2V1CCiehBFc
         KGCGaKKieRGDUWFIEjH7jwdqw/fZ4fiTbsK9pQHpe1+q0OF5V381FmvNfwTWOEcFsXKM
         srG7Rma5yXEBfwrLDb8tZ3BHIDCKsJGYqfAshpY8sBy43NUs0KNB6jqjoVcA+GeX8hYX
         /63w==
X-Forwarded-Encrypted: i=1; AKwUvBz3JmfYLbH/85EtoJivzGlLsWZT0ot94CEOvOOnKfy/devxjiojTCB5qapfZZbjow5HgWuaAR796RJ4Kyrj@vger.kernel.org
X-Gm-Message-State: APuU4Z/7+XamHGZxJYnvI7NMhmqvPoKEfYCJCw96AWk8bWeio4e/Eg3a
	S0nKJrJS5fSeRwkiu1iJkvcxmtSiEDEMBbE/L4GkJcWoEPuwJh6GklDutVi3uhWv9sMQ6PMq8wx
	eQX7+z3djz1Cbm1S+E8cVnTxiVvDTfsHBdYNzAfL/
X-Gm-Gg: AYBFou3TiJvosBk5suWZNpFSLb3ZqKyJsA/Zu9PMqH8koJYBXgdaJPXVHYyRtWVBkHP
	eBtZYKnWyLMLR95gx7Kme5iTe7wvY02tB6CdfSYXmLsXInWYeS4IgVxVS34kYQ3rbo3IIma234i
	0mNKgZucFVRiRTrQNs87kgLihRs5C/weGleM+JS6NBumZGFIfrV/qjfDEcb9z9bnftzwt41Va8i
	2IN5fAWRfe2H/s92Rs9xOFU1pfz99F9zo01BNi7uaKCeI5fLKZVVyCXTDLkgWzqUdkxLSxddaLZ
	bvxsRJcSPZsxrOa5rFt02aeR/y+SLavNyRzCU2CHYfvYECqeb5D7JTspW3Ju1n9cWazx8LSh5z1
	mJbXqwBrmc5QxEKe+cjW+Hn0pEiusl0lI5u06g8KBk2sdCyrhH4X3ZE3o0Wn/rUsy86Y0cuc=
X-Received: by 2002:a17:906:9946:b0:c4d:939:526b with SMTP id
 a640c23a62f3a-c4d0939530bmr80653766b.0.1793754878307; Tue, 03 Nov 2026
 17:14:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <20261030100215.6f8e0d4f@pumpkin>
In-Reply-To: <20261030100215.6f8e0d4f@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 3 Nov 2026 17:14:26 -0800
X-Gm-Features: AclHuK-cSPxC_sFXLW9VVvDKj-9cMyP8tHQ9MAfu7xEMrtFl6vQvJ8w_LlboHFk
Message-ID: <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 29 Oct 2026 15:05:45 -0700
> Samuel Wu <wusamuel@google.com> wrote:
[...]
> > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > would be different symbols at different addresses. Please correct me
> > if I'm missing something here!
>
> Only that the user might really want one of the copies.
> Sometimes there is only the copy.

Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
pagination to cover these. A prefix query for "foo." also finds the
copies when plain foo does not exist (expanded on this in my reply to
Andrii's Oct 30 mail in this thread).

[...]
> > > Have you tried measuring it with my patches that speed up the kernel
> > > 'search by name' code?
> > > That speeds the lookup by a factor of ~18 (testing the code in usersp=
ace).
> >
> > Not yet. Can you point me to the latest version? Happy to try it out.
>
> I've just forwarded you all the patches.
> (They include patches to the tests and scripts/kallsyms)
> I'll copy you (and the other people getting this email) for v3.

Thanks for forwarding the patches! I'll be looking out for your v3. I
tested them across baseline, baseline + my series, and baseline + my
series + your series, using the same two benchmarks and setups as v2
patchseries:

Loading a BPF program with 11 typeless ksyms via libbpf (8-CPU x86-64
Cuttlefish VM, 273k /proc/kallsyms lines; BY_NAME, unfiltered, so each
query also scans ~35.8k module symbols for ambiguity):
- Base: 156.1 ms
- Base + my v3 series: 2.05 ms
- Base + my v3 series + your v2 series: 1.95 ms

Perfetto symbolizer (8-CPU x86-64 VM, 175k /proc/kallsyms lines;
BY_ADDR; init / 50k cached symbolizations):
- Base: 129.1 ms / 28.0 ms
- Base + my v3 series: 0.04 ms / 3.4 ms
- Base + my v3 series + your v2 series: 0.04 ms / 3.1 ms

I'm seeing your series help most when the vmlinux name search
dominates: on the Cuttlefish VM, a vmlinux-filtered BY_NAME call is
5-7x faster (hit: 8.3 us -> 1.7 us, miss: 9.5 us -> 1.4 us).

[...]
> > > > +     __u64 query_flags;      /* in - query mode (enum kallsyms_que=
ry_flags) */
>
> There is no need for a command here - use the ioctl cmd.

Agreed, done in v3
