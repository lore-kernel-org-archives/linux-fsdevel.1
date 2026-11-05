Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793914614;
	b=oDkmjx3aOg0fqK5XGgLdqWlBtnHAaI4jyMxmwr80p2mpsvSKeKoYDjlyO+TFleJuqxu7
	 rwQE5OFeJ3QGtLZaAJzawapQzrCTtOJP83dhzL4/n7Mrx+R8K1RR2msMs5anvKYINUxle
	 MPWXJlLxSgJ4YZeE53CYR6iKWZLnpg9GL1AIQejCWYlepbzIcP6PmO/Fa4wnryBC2U4RU
	 bnpBp0kawL9C/jNMEGhXXeUEB5b6jkWAcN3yscxMIzZaydZhEs2dG2Jv7kWVXIEl6nGb8
	 Q8mdfU+qRhoshT3H+J2YVopT5GVuj+kLh4iSyTJ1Pz8I/ew/xhI2JJl2qxvfpOiR2QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
	b=XTikAMJlQ4r9SzzwbRqyNVeZ/aMMAx4cOwdutc+R2eVetX55mxJEghmiLpkdR6KXmkdp
	 D3y5Q9wwh8T3sdqQ78FuMUCUOWialIFN+8IKCMhSF+1AOkzrwaVe6NTNmM9OPEpX7WO2p
	 x1fYCnoqaYZzDBCB3Td4izP9cAihRbShMAIBr4DfKbiQev6OKFQmyJfQSamnA15nZkv6M
	 kQK6exPAkM/HmdW55tFybwmelTAmUH4AMgvYEji3Gw9FKPBR7/yFlYLIfgNYZGMRTmvcO
	 I8tmB3ZCcOvZb99tWAtc1PY/aHolZ+1dkQTA+2IlvtVCH6rsX1fZCj0jMmlTxhlOHCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qNV3YK2A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9717606A338
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 21:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9717606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qNV3YK2A
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4682977f9aso275645966b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 13:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793914612; cv=none;
        d=google.com; s=arc-20260327;
        b=IhM2CFxRMTzigedYfSpFEXD10eO8+DzJcxEhJHdbVHdNieFJUrN/NT13/4AQQSXr89
         U1vOA7LTzsTwuVSNRVs5PCYlWgQjq2FnTlfk+92WEQJk0NZDvt3DsXI0n0XZ/eqdUvDW
         hefWgTUZG4koQGzQ+YYNYZzBSwZevOUc9i6DRVhQJrCArJIhtSZrzwH508a9VRbz8Swi
         KQJ0QbfQt2FAJaBBcWPeDQBaB9w0708IQbBQkGOLUxMmc4zsCefRCyQijyzCSgwPvfza
         PTbyvnqqzKyshrikRsEsgdzIfWillRm6bLc9f/61WHMmBDlrR9x6mawwp5A1oN4TIglI
         bTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
        fh=HruktlcO+MK4CVR8jOTH9B2FRd1p7nqdJDWWbg9OkO8=;
        b=daGjqCuyFcsg2brWJ97WcMHpXtW2F3ZQQPOCXlr18zNjCGj3mIYmd4YGAuQdduZdrg
         DQwg54FKmovqODcAfBY/W6pjfkacGbMor2FVQbbTMWfYQyriTTFI0Az67hEwIH8IF/lS
         bwi2Pr9z39fGpysXXRb9N6ojIjoXnPP4+wwCrWp2XWjh01MAs/KTd9wSoIiT9FNuErxk
         urJqecjlOFLXo0v0G3QTA77IQfaRjkkp36fu5GYXnH67apxEZZ6nj5rmSeZ9xooS7MbK
         jaQfhOQnS3gRCLS6R8W1Cuhwwki+IdQ0OF13N7u/+qWjO6iBk0huH0AZibf+F8CHK/kV
         /SqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793914612; x=1794519412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
        b=qNV3YK2AvifU1tOsCQ8wk4axq2Bpnp9T4w05lcq35MoN1lflDph5Y1IYtTpLN9oiu1
         oljv6zhoDl0Vdx6KwOE+YZ2XrvF12KIBahqeuzL0AI1Ihf1xglBIFGRlNFmbLRw1BvGj
         cHOsnpHe5ExcVUNebf5XytYqgD/im+o9YfI2/bO5gRjiKXBfTL4w9S2eMuvmZ4trc6CA
         kCNJxMHTFWh4eiUO3KMPLUXRVAjTsqzWtt3brnLtM+MWPucllL2IlplxbMf3C29B/5Fm
         Zq9m93kWEpns5SBYbYB5Q3+CTVkb/fUXg2wz7C4TsaW16nXsgwuTB3NnvQNvu0l335c9
         ZYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914612; x=1794519412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2E4Xme3iGj8AG7tp5kyRL4U0PVxMRPmUII8euE4aY4I=;
        b=N8uUWAyJ+hhi6FmYKWU+13+fE6TtEpd9sowSDkOwzfTh+oRMU05ghTkSXlVRS4psZL
         yaaOeqsKfKXEd5TslLp7frf9bZSEhgMjicIo3XG+jGRiTEfPV7vmbA3xiwQKuw8qJB+y
         J29yjtVYSlY/3S1hsS/BeCyqcBVTE6STlnTZl0IgYj2Euupma3c+cOQKZCePTQJgQb/3
         gEgYl8Bm05OVzgpyJC/Du7w8Dq5963aj3BcaS+ehXxQGULYgPUiZgmyLdQHl7vYdKEEN
         ibwhEJNsTZNx9RyaC8cCNxQgZsgTdQc/hHF+3jb5BCmtDtCt6s30+d0MPN+iEuJp7j77
         3Lvg==
X-Forwarded-Encrypted: i=1; AKwUvByQQEYVDDmOOqf4GHzxzOy6Uj2ueI3BfBNQzFnx83GASrUufzofxtWvB84iY6qqfNV1AWEHXgCdvbhF/+CF@vger.kernel.org
X-Gm-Message-State: APuU4Z80yjMX/9CPKu1Z/homRboe6VFxD6RGTSrnyxtbWjtFWrPHFC6c
	bDM8Et/DIVzierVXQJpir2K926sqJUlS2cW72EygRG9nxGfzM7J1nzpsgn+kdzn4Bg1RPihYhLV
	CMkM3ep0oXJQ9xy91o3Ts8qHtyzkUbLzH9uVpCOfA
X-Gm-Gg: AYBFou1Ln/SeNcDo/xwMRcuE38H9rNIQS+rl5lZpjIOaBR2pMxZy+sBHgH4ZTjfhwSL
	eokPpuBDS595cikBvpwJxCkF/atyd9mS5/DHN8N/CJGSomb85hJ2ZvspXDI+/dgHMlbeMVZVA+V
	dfNdnQEYLkzFjB0i5GhGdvT2kJQUrX7DmZ3Q7EqGqAeF+R161btJCXJuKJ7Iighog09eLiOS/bV
	qU43YXjNq5URNqUtYwQB+K2DzBgeg9s/v53UxwphLaZFEjo+RFTxLGU0fNud5TIS8zMcF3NfWan
	l4JumjOy4Pp9WkqDyc0VhgAJMU823L+y50HZzCgbq+a6dyOAVjSd6Fv2BcsGyQfQ4NaaglwP3PQ
	IAhAeYDeWeZPMj797VC1k0+Y1A88w1KYAQvYbhwEp6rT0QCPplSfs2WZlcWLzIqBgylgjyWk=
X-Received: by 2002:a17:906:9f89:b0:c46:645f:cedf with SMTP id
 a640c23a62f3a-c4d3546bf6emr55329366b.15.1793914611758; Thu, 05 Nov 2026
 13:36:51 -0800 (PST)
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
 <20261030100215.6f8e0d4f@pumpkin> <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
 <20261104142307.431fc12f@pumpkin> <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
 <20261105083712.14847dcf@pumpkin>
In-Reply-To: <20261105083712.14847dcf@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 5 Nov 2026 13:36:40 -0800
X-Gm-Features: AclHuK-4-3cdEVpuwe7ZR8h4IzWEsLs5z4V7r2FIsMuL4z-PpEQaIZ0fXLkqICE
Message-ID: <CAG2KctocE=kj2CO29D0tVmrBeWmCDYA6FhpHr-7ZbD63GM1CsQ@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 12:37=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 4 Nov 2026 16:05:52 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> > > I think it might be more sensible (less pitfalls later on) to return
> > > the symbol number - not that of the next one.
> >
> > What pitfalls were you anticipating? If the current symbol's position
> > is returned, userspace needs another ioctl() call and an -ENOENT
> > check, to learn that there are no more matches. Alternatively,
> > returning the next position means every call pays for a look-ahead,
> > which for an unfiltered query walks the module symbols even when
> > userspace only wants the first match.
>
> I was thinking more of the kernel api.

Ahh ok, makes more sense now. I misunderstood your previous reply to
be about the ioctl(), not the internal kernel functions.

> The 'position' is just an array index.
> So a 'read by symbol name' would return the array index of that symbol.
> A 'read by symbol name index' would return the name (uncompressed) and
> do the lookup (binary search and linear scan) to find the value.
>
> I've used a bit in the 'sorted by name array' to indicate that the
> symbol is a duplicate of the previous one.
> So checking an 'exact match' for being a duplicate is cheap.
> But for a partial match you start needing the name buffer to be in-out
> on the read-by position request.
> So you start needing 'read by position' and 'read by position with
> name compare'.
> It is likely that the caller will need to validate the name anyway.

Got it, thanks for clarifying! That works with QUERY_BY_NAME in v3:
- In the UAPI, the input query string
(kallsyms_query_by_name.sym_name) and the output matched name
(kallsyms_query_by_name ->kallsyms_sym.sym_name) are separate buffers,
so the name buffer is not in-out.
- In kernel/kallsyms.c, the vmlinux lookup only needs the two helpers
you described:
1. lookup by name/prefix -> index
2. index -> uncompressed name + address

> An 'interesting' idea would be an ioctl that returned the value of
> the nth symbol along with the name of the n+1th.
> That might get confusing though.

Agreed, it's simpler to have the ioctl() return a single symbol.
