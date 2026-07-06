Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BA24CEEA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356487; cv=pass; b=TLdjjJ6j8NQ4X/nFsewp0xEQEIGQqamYH4Ksw74pMnTOK5QqQ7PI6gOlYYTBHUZaQcW24DmsOqWP5RIpX+g4E+focFiT4axjtap1dbb3ck0ip2F1b25pG+AyJrVoKXBWAsS7kFJ+1h9m9wD9aAvds6RcmhoJhsx8EBWZ7SP7SUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356487; c=relaxed/simple;
	bh=4PHgPVZZ8sj1dNJeoG46xQkWSVN7vyFHtfclac+X7d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzGKe9MjhKwO5qPqadMCNjN0J9jmcCd+Lmog7Gt5JtEw+N/gC3inknxH9J0CIrq2NFv+taXqDLiyaRKDARgZx9R2f5mQeQEoBtIUxBWBo10cex/gP2ipUkOp9p9EcorESEHxPCpQ0wmnRMjDyUaIyeZLqxV0MT4Z2mbfEZyf1M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRs9Isus; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRs9Isus"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-495c63c4141so2406279b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 09:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783356485; cv=none;
        d=google.com; s=arc-20260327;
        b=hIuaJQS344a/SMaQSTNk9BGaI3QGz4A8ptLUUifBbQs7jF9E4HwwZwBQ7JqKlIwqQY
         swdgeqWiM0gvBQ1Y03y1AXB7SoVRf7+lUFW8lanRMr4AhJ985Scms/FweMmyljEWnLx0
         TADbsF9R85E02W9QTf9lRb+YOJ0DrNMBUSYAbTj9ma7xvPmx9Q5Ul6MH3Qj9wrKOD7Or
         bGpm96jXrwb8fArTiEo26CWHYhrMPakJDU2N4blSNO61WvgoeCfurwX574V+dwQGy/LA
         o6FeZV+rmhYJghVLTKtQTxG8k1jsMKVaI9rtR8IC3QxrJFxco2nQxc68HTuOvyGmO7cP
         1x4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zarcUzp/fr15vy/Sk3GURs8seOzb+QEYuzaIJK/NbMg=;
        fh=PGKI05svrHgDtx9Nqf8hRUG/2Y0ii99px+2gMI71EIU=;
        b=WoA/4KH+t2yCEuzgZvOwf7lDKIj7W+RyDhAdNZNf0ZOVmeuStigGjIHhDUM7nc4lmp
         1mB2IT8OVqBkhV5FhzJ4tetvs8WoMrCjyVu4ILX69T4ulOs3PtwK4UfdtzuFvzBO403c
         MsJda8UjjtnVsjY9QSVOWpY2az9VQugFgDAvV+9kQsaxqs48bN7iCTlrq0Pwl0UrZkab
         mo/2chAFKgUddG/DV21cjPWbNhAWtje6WN1lLjoSmLyvBImTwIozmc3pzsQA1Zld4HIZ
         lTqaWhUKPiTIcQbU0sSKJ9V5hq/istIUCtD3+hqer8O+d0wbca9sraGZkmBpwmAnkDXo
         vDqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783356485; x=1783961285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zarcUzp/fr15vy/Sk3GURs8seOzb+QEYuzaIJK/NbMg=;
        b=QRs9IsusX5DhA8Fd92WNEEu0twzkgeu7adQ4L0B48QaxF5lhvnETBtPKGecRnsD26P
         BpcR+Pm21HPu01zaJmapxUjXUAo3obsi3sTKTdTo8YiICcNyGWKSN4aixwe07otdh30D
         ZkPK+gJ12HwCZDJ3Ke5gtu6eFhnkln4t0IeszGtowVMM9daifpVNZ0dBkatP0cU35sit
         vcIprt9D4S4fx8Zk40MVGZEJRr8vw3t3quQDn+8vNx7EMGI6WiYPOJeXUHl40+1qGo8M
         LVKlQxvnn8ewtU3LU2iXfIfqKOyQ3rmLo9jYBTUlZ7W/Kys2BdtdwTkyOIiQzNnpjn5N
         2xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783356485; x=1783961285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zarcUzp/fr15vy/Sk3GURs8seOzb+QEYuzaIJK/NbMg=;
        b=UxlKfzqJquFl2jvFLe5O8g7KPh20lC7xsSwf50Kvvf+SAeEQE3CEabz/NF3i5/avTX
         P0VHwEI4hFWmxE1her/E4kfz7c5prneSnFVOQBm7ZOx53GVUG9q1TFXC5qCfv+AiCha+
         0EYPM/P142d8Z/bnPfsZq3Aor9f5WuDjcTCzXJ89jXWpaWiGthF3L4WDv0sgzA8dAbTx
         C2DnglTFGfrNFUVirz5QuM6MpdbhwVU5UPNttmi+77hCzMMLmw8mdUm1XdskJV1iwKaJ
         lUI94oTlxaAk9Dn3rVHrX7jywxC2AWfOb4hcX9pvlp0Ma/3m8c8RCdKlHoQVb2LwMPl+
         dBeA==
X-Forwarded-Encrypted: i=1; AFNElJ8Sv89X4ae+wHgWVwL7Ubavb2PW6Y7suX5keg+kG+uvsDerim31/ZW3E+fbS/1qreZfxOrFxPLXBZO9mY4m@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkRAQUk06Q80h8wBpGIJOJPPPVEV0F2K7BZEckJSs5Km7+a2b
	XAyZRc3bgmhNYZijz8XfOYGWFTMqJ558IYu5j/fMX2+fFcIrINUenoML8G49fI/mFQrqlrCg9Rf
	38Yvv8eBBIJcXTl7Q+xOgVwPXcuxLjNU=
X-Gm-Gg: AfdE7clbDFxakPhyi0yxoaFUwiM9q0Veck46XuO5CYIEW+EpLS6sef1Rb87nkdiML3t
	BAAGTy7bs1Q/zOtDrGX9GJ6ZZoIDnolXOJcUWW/0FpEqbC3eYM9DZbvajSfBDVj21iC3f/LaJYF
	birCpSSsx7V8NsyU3aZpNgv1JG2j6Rxr9gJTWCFcLVuggahZyrRrPJzNb2k6zPfMRsaNXFxnoN+
	aPf/sh9IrPOtVPIK/KVYOHZIqZ29ghtFWu1SH5H/vtx2ayCz+TBlmF7TMdtVQsa2O3LuQ==
X-Received: by 2002:a05:6808:3986:b0:497:df42:1df4 with SMTP id
 5614622812f47-49fdb9341bemr1075973b6e.9.1783356484621; Mon, 06 Jul 2026
 09:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com> <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
In-Reply-To: <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Mon, 6 Jul 2026 09:47:53 -0700
X-Gm-Features: AVVi8CezoZXmxdx0EVJgscHRgUSuI56V3d2lgnD3ARstqF0mvBDKn_k51tgqOEc
Message-ID: <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
To: Christian Brauner <brauner@kernel.org>
Cc: david.laight.linux@gmail.com, jack@suse.cz, jannh@google.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
	shuah@kernel.org, viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Historically binfmt_misc has only matched binaries by magic bytes or fi=
le
> > extension, and always redirects a match to a fixed interpreter recorded=
 in
> > the registration. This is insufficient when the match requires parsing =
the
> > binary header (e.g. inspecting ELF program headers) or when the interpr=
eter
> > must be computed per-binary rather than hard-coded.
> >
> > Introduce a new 'B' (BPF) handler type. A pinned SOCKET_FILTER program =
is
> > registered in place of the magic/mask, and no interpreter is recorded:
> >
> >   echo ':name:B:<bpf_pinned_path>::::<flags>' \
> >       > /proc/sys/fs/binfmt_misc/register
> >
> > When a binary is executed, binfmt_misc runs the program with the
> > BINPRM_BUF_SIZE file-header buffer as context. Returning 1 selects the
> > handler; returning 0 falls through to the remaining handlers.
> >
> > Unlike magic/extension handlers, a 'B' handler carries no interpreter o=
f its
> > own: the program chooses it via a new helper, bpf_binprm_set_interp(). =
This
> > lets the program compute the interpreter path however it sees fit (for =
example
> > relative to the binary). A 'B' handler is therefore a strict superset o=
f the
> > existing magic handlers -- any of them can be expressed as a program th=
at
> > matches on the header and sets a fixed interpreter.
> >
> > bpf_binprm_set_interp() is exposed to SOCKET_FILTER programs and stashe=
s the
> > chosen path on a per-CPU area that binfmt_misc reads back immediately a=
fter
> > the run under migrate_disable(); only a match that set an interpreter
> > allocates.
> >
> > Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
>
> Ignoring the blatant bpf abuse here I think this is quite workable. So
> this can be turned into an actual design and patch imho...

Glad to see you think this proposal is in the right direction.
Just for my edification, when you say "balatant bpf abuse", you mean
how it abuses the socket bpf type?
If so, do you have any guidance on a new type or should I just take a
stab at it.

For the proper RFC patch unbastardized with tests, should I start a
new thread or is
the convention to keep attaching it to this same thread?

>
> Note that binfmt_misc is namespaced and can be mounted inside of user
> namespace + mount namespaces fwiw. So a container mounting binfmt_misc
> (a fresh instance - few do) would escape that bpf program. On the other
> hand it would allow to register a custom bpf program per container if
> needed...

That makes sense -- but you will need CAP_BPF etc.. to load the new
programs though
if inside a userns.

>
> --
> Christian Brauner <brauner@kernel.org>
