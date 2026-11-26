Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654410;
	b=4M+d1Bv4/HL+KQtsn+WJT9trJ7viXY5c1N2ujOKhW6cYN4q8zpi5zdzhu9XcQzt5deMo
	 5Paog3aHsf+hTzijN34tqo7eSSrKywglWkmVUfzj/nbdvCmlFnEqNwE0ScyxwkF2wB3jk
	 80k8728opqEwstfkQoibve2jFZdPvIU9g7bqgcH8vF7BIlZ+UTrvf+B6SvG8ZXaqYyg+J
	 qsBAPFe+3Trel1XAISL5DpCX7ad9gvwk/uynEXv9Rt7mRms7vK2R7SUP5X0uh9uEg27ws
	 RP6adgWTOgaQEbFb0IDjMyWzr3veil7sl8EqpEWngj/bDB9bAV17/jpIbtjATzmEVpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
	b=A9eB0BJu6+JyWHq48C6BzKYdr20RdUVtvg2nF5plspIbNWhLFsQvk7d6UyyqiS43PZF+
	 DV9mMuaCJhLGzzCfQUqfgnoosM0Whj6rwYEPLodYioMuRZzMmDsLV0rOeWSW2qUrWgzJ+
	 eFfzz+1VzIKPUmR+X3VU/92s2y/42kv/LYl/QnRWFO+9s/9m77g1yWc3OCnbYtaQuvEFY
	 Z7r27zurzNNlH42bhNUyx2k5vOtfVT6X5xt8BVdIvYhUh0cFBdq5cRRYCC17oP/3bLd+s
	 mfw29Zn76jQBlRSmCLTrMu1fvKddZlerj1CNScqR6EbPDflr0g9yBMeyxg290B9X8PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMbLOmTg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E00606A339
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 00:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E00606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMbLOmTg
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so830268466b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654408; cv=none;
        d=google.com; s=arc-20260327;
        b=jYC3v9yDLZNGHAUmwmcpnyt6fOL1CawXvKxWSIGCof8MbKQtUvBN6Jajvc4xs9lXK0
         3BrzZ5+h3kFoKzmxngJCH853vlUkq+yGZZrdNT3RkuFSDwpjge/G4FBNZ36cGGXBZvJM
         zllhOlFio6yNNR41hRTHGIeBjkqVjvwv1jxghZTYwt7w0Llc7bqy2xtwEZkpKpUsvRNf
         YdIqnEyE0UL1JSMbe9uchZl7PBJzQsZ0O5otz6FcsaEtcjUET4b/A8gqCvBJCTZ716Qa
         DJhgq+XDMvo7BRI2MW7cIfEoCyJ1Iogs0120GF5uOdoLcbo6AISVkq1Nb0GbU4l1nAqP
         cCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        fh=FDv0hBYzJIf10LfV7MLIqZe/mO59aW26ayMwpYCMGeQ=;
        b=IleVA9DhxtUviZWzyAZwZoXou39OId+V5NjrJrMqpbSNgFmnRWl9ChX74GUdK+u2zA
         NoBu0dMm01uQEEs5TASMu/C/lo9uSBT7XG2d2P1faout13bd6WGD4hFL+xw61cQtNIfi
         oXQtV874mkDZcYXr45bmzaDmtEW+lbHYZTLN80n79TULJPrFcABIFHDlOYc5ceQHx2wh
         u1cudkJom3rKzM6YYe+AmOcaSxZK2M3xN7yUgzDnA2LDqWZltLqofa8YW2zlL2fkVusZ
         otHyLPMavvMLR+PyqSn9zMTwDPATI2a0ojDUbSI6yceh0lbiwdy5J+a/tCULh6CwJN9O
         XFkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654408; x=1796259208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        b=OMbLOmTgwkBLdVF5EdkYSC2XrgccLIkkqOXgyFgiuHmBsv8YiKTp9E0NEIyhirgYwo
         BZ+ApH53YZ2KTVkaJNbDjcMue9DCSXid0Du4+70qfpSn/U6BPQcaO0rTHvaEKiMrhjq+
         cgrO6KnCn2xh6qE6NyajQBDq/7N3cmFb2502QyBeGyuN0J8TZ8STFtPa+xPXpE5PEied
         9EIDboORco4TC6wv1vXi5MBxzHo/qEkcV1RPpsCU6P4rl7yl2ijcQhep5KTjor4bMPiQ
         FloIu+x3tOotka6vXyHSWrSW9RsgR8EkvzFkVBto/arghTtNsJHfG3gnYoPBAaEQS9BY
         49RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654408; x=1796259208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        b=RzjZqECD46C0Op1kk0y4kP/eP8Tbnke14c4Tyr9tJWWCAQYlrbZ74vjmifxjR1GUeZ
         jgZXr30/9A/3264PF0apcMob3P1xnpjWfBndEPo15yVZg9LNUx5is8R6sOVFhf5LROuf
         xSb+3bDMJfhHw8vQcPP+njprg8H9iWcbtDQuhQeiMw790pkdseSxVJiIPJ3mXN59Y/V5
         bdc+IbHVAk+VzS9gTKuo/OIXVkBkHq7rafgvlsJaaq1vmok4Px1Kqmp6fWvAFovcLFel
         v/DAAMQb1EIkdxY298Ka5lE7iS+NGy+R9t8057Jax2FSVMZ15GioSncmeq+eQ5G/cTyj
         w82g==
X-Forwarded-Encrypted: i=1; AL+hErGLVsAnTK+A8euNr8at6OhCVDqm0YHLnmfH22ui1Fk3Ozncw3dw5DrCifYggVlgEgeT+3gQ2HkySDNcQZs5@vger.kernel.org
X-Gm-Message-State: APuU4Z9ByNwARDbIf7Z6hrvYRxt+5D5PNRFHpIB0vCDWHeGzk010EtK8
	QjNiiGSKYcrqFkfj0sfq4js5PBrmFkIQmHERYQ6dTAPjYXSqShLz2Nog5F3JNpQ+1BNymNsyQhw
	MX3Q/eA9puyGkGFSJUwiuk6ScbMHj30/xvlJBD44Y
X-Gm-Gg: AZFdTZeQuL+CwXf57AZLTojWWssWjUsIgqjhqswqjYrG1oVPJiVvhg9hRhif1qKFJkP
	MRRTvpB6fXYbjWJ1MlahBwDUKSawVunEXY1swA0ZrrHRMUJXy05vqiKy5j9WN51JVA+W93oLmiD
	58E4E2c1rY9wrkJ0khEGE7O5LDrNXt+leIRddW60kFHKzLK6PpYriKUkWY8JDDieTKvNby1mABX
	GdPYdf0P6JYLipIqlwbRGBlRB6BLXQhEyyeL+Q8qdcdHU6hzSiWStIzmvTm756UM9CQRmBnVcMm
	QL/EqGA6Ih34aLeIADGhzaFss5bUvfDadkBll0ARf+TXL89OUnDOQX9iAIt60DrEriTh/4Zl3Im
	ig5oyhZKHP4j8klgfITIulZA80EZYp+ahlVQ9toJ+JtnaJHxHewhFAz2z58f0hxGsDzU=
X-Received: by 2002:a17:907:c643:10b0:c2e:4292:d27e with SMTP id
 a640c23a62f3a-c513a816d3amr1138026566b.22.1795654407168; Wed, 25 Nov 2026
 16:53:27 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-19-wusamuel@google.com> <CAEf4Bza48tGhcUhFRhSSv3qijV0uF8YrAQcLM6Qv9az-8zvK_Q@mail.gmail.com>
In-Reply-To: <CAEf4Bza48tGhcUhFRhSSv3qijV0uF8YrAQcLM6Qv9az-8zvK_Q@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:53:16 -0800
X-Gm-Features: Aa3M54rfuKAHSB0QMI506grzDhwAStyJm9gAvy8QXVpNXfEJd-B8LId_HiOPEPc
Message-ID: <CAG2Kctq98pvyV=jmN0Di+p7m0AWQKg8+QF5YBvdLi79kTJaKoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/9] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY_BY_NAME ioctl
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 12:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > libbpf parses all of /proc/kallsyms to resolve typeless ksyms.
> >
> > Use KALLSYMS_QUERY_BY_NAME instead: exact names, plus "<name>.llvm."
> > prefix matches. Ambiguous matches at different addresses fail the load.
> > A missing strong extern still fails and a missing weak extern is 0,
> > without a text scan.
> >
> > On any other error (e.g. -ENOTTY on older kernels, or -EPERM), fall bac=
k
> > to the text parser.
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 99 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 44134421bd7d..f3f3475a64d3 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -59,6 +59,34 @@
> >  #define BPF_FS_MAGIC           0xcafe4a11
> >  #endif
> >
> > +#ifndef KALLSYMS_QUERY_BY_NAME
> > +/* 'f' is PROCFS_IOCTL_MAGIC */
> > +#define KALLSYMS_QUERY_BY_NAME _IOC(_IOC_READ | _IOC_WRITE, 'f', 48, 0=
)
> > +
> > +enum kallsyms_query_flags {
> > +       KALLSYMS_QUERY_NAME_PREFIX =3D 0x01,
> > +};
> > +
> > +struct kallsyms_query_sym {
> > +       __u64 sym_addr;
> > +       __u64 sym_size;
> > +       __u64 sym_name;
> > +       __u64 sym_name_len;
> > +       __u64 sym_module;
> > +       __u64 sym_module_len;
> > +};
> > +
> > +struct kallsyms_query_by_name {
> > +       __u64 size;
> > +       __u64 query_flags;
> > +       __u64 query_name;
> > +       __u64 module_filter;
> > +       __u64 pos;
> > +       __u64 sym;
> > +       __u64 sym_struct_size;
> > +};
> > +#endif
> > +
>
> there is no need for this, libbpf in kernel can use kernels' most up
> to date UAPI headers directly, and on Github we sync necessary UAPI
> headers into include/ directory, so libbpf source code can be built
> with latest definitions of kernel UAPI. So you can drop this part

Ack, will drop entire #ifndef block
[...]

> > +
> > +       while (!ioctl(fd, KALLSYMS_QUERY_BY_NAME, &q)) {
> > +               if (!ext->is_set) {
> > +                       ext->is_set =3D true;
> > +                       ext->ksym.addr =3D sym.sym_addr;
> > +                       pr_debug("extern (ksym) '%s': set to 0x%llx\n",
> > +                                ext->name, ext->ksym.addr);
> > +               } else if (sym.sym_addr !=3D ext->ksym.addr) {
> > +                       pr_warn("extern (ksym) '%s': resolution is ambi=
guous: 0x%llx or 0x%llx\n",
> > +                               ext->name, ext->ksym.addr,
> > +                               (unsigned long long)sym.sym_addr);
> > +                       return -EADDRNOTAVAIL;
>
> I think there is ENOTUNIQ which we can utilize here

Ack
[...]

> > +               /* Check exact name and then LTO .llvm.<hash> prefix */
> > +               err =3D query_ksym_by_name(fd, ext, false);
> > +               if (!err)
> > +                       err =3D query_ksym_by_name(fd, ext, true);
>
> err =3D err ?: query_ksym_by_name(fd, ext, true /* lto_prefix */);

Ack- will update in v4. Thanks for the thoughtful review!
