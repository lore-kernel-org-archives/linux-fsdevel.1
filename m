Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793058730;
	b=EUaQdlKVmKY28Z7wPrDUZi73Lupsxy3JK0ru9ubfxJ1k4Lk9r5FXUUx+0Rkz16THPHmi
	 eT9PbOmSJd9q9eUA5xNrL6lZ/8J/qZMRYtGEsXn4ddhV/IC0XkC433Vog8MH/4lkiDcac
	 04V+3dSbq6IKEMQ2kc5yenk6gBI3COTesiFZ1AHPJ6m5Nhp0WkjCNvRD5RtXhC9qdiUNp
	 yoGf+dfMVjZ/Mc/IHpJE7iVu8Tx6RW8pIC6b4LvwqefX+chGW8NyG1ZyedTutK5XMdG69
	 3fyDIWi/+XuQxzSPoZIsH5DfxZXwh/Q+uIvPdgEoOAvHoRB74dHyP2Xv7Z5l0BY8bkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
	b=q38PEwzhQWzcBtdwomtyz+wq+Tb7QY+p8a3W9jjbd0NzqCceB3GPgRWL/RnI6K8tzV5B
	 NamlhMNVOsbooyD/kFckrdA2NFTiIVEhJo1JrwBzCrUglvi1TcXkh3EsMNt59uc9xKGoo
	 QXSwXJHteNpNv4NB31lxzQ+7PVp4qzYxW0e4L7DPP++hzL8nPejuewGGjUWimCvtkqkp7
	 E3LwB5c9l20mPu/i1ql9ee9dsqUK8cL8VNXIstDDRxFYGBg0pEk1E0AalRkFkPAclTclM
	 9j5upwms8O1cgZxnf5CRoz1fDMHtEFmfg/Ktzx8KdRBWw/iAIff2O5uMdtgTJsDu4Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75C606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 23:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB75C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3fd91337baso507206966b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 16:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058728; cv=none;
        d=google.com; s=arc-20260327;
        b=EC/Q9dVrfVfkGzHfVVr1h8W5uZx23Ommjn+0m3aq67V57y4JdFBMZ3683jz9ywdI3U
         oCGMZH+/m6h+3Prs5zsrsoiJoGFzedr/+3glG+RX5nTfJzVKoGMA22qWK1af98NqlLn+
         YKwIJNLMYtMgjGo0J/gCDJuFHnz+L49p3FoODHkCXtlDOoV8hf4Qgr0hGHA2Z7/CRGuZ
         jWxLON1pwaVwPX6mwil2U+tg4zr/p1f/FDSjuhVkW5S7AYwKs92DYpRGanv8fCjVinL+
         JaK7Mogzdmdqk90BbDtbzKAVJeuSQ/apuvUmlZkTzWVJbpHFiPCToujSFNacFXU6jzEt
         ewWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        fh=NXNqrvF7bz9a14WOvsTRYYx77qrUf7JxWr4RV7lVji4=;
        b=crQTDfiey5qYP96kDDdB6vo3tmUg3krov+nXx4n7Z4yAEbl5NGK40AXNu6Xuyn4Zmn
         IDawuP99X/HzHaKKlM35VH7sjHMeOxRMPzqdCnTNxOjTZCl+iLQYmMw8TJREbYhaaz4O
         era0xlNEULMcTFh3OdgPcWhmKaXLctjiDwjFmLqPxx8NI9on4DAUiQW3i5ZCgG2ZSLFm
         TxildWhByfHDpv8ukSMcbSoElS22EA+mgzzUPLByqF1CYaMzJ9GXt16YSY/tO0VqlOw0
         JbC6qKtoFWGWVHzLGSKG4Rhg3GrVzcTDgMkxzyj5UIq36Vmnhi+phHaiqbpz+VaAVctp
         Kkeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793058728; x=1793663528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=IrwijN25Y5XuhkNoEvpxTGUzu2F8Fw7yumOC6bQX+sv9sI5cIkUQ+8qDyW8Rn0leIE
         KD/M3UgHYaJH9qxw5QEzap4cvaO8QRp4WvUy/b8d8qlbP4zjT/NLwA46mVK4rk5TE67Z
         hbcIs7JRXy3S3BU1Zp46QexhDFTfTqhgb9F5yDiJoNepIvxVOAnGlUkvuMj53pVOulEq
         nY7AospiQUxyoh3b4b1zlSlhp0Xm7S9U0DWHUHqyywQpS6V9BxBGr6qPvm7+SL/x95K4
         vKS38fvl7h/D+VqUiNNcMPjyNlpB+LfGZlaoNjHo8oTsgp0eeolgiheQhrTjRg97kEV2
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058728; x=1793663528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=Dqav2YvCTGWFtA0Bn7MTWiUPaoJl1uEx1SPjw6dd8MFoQQrJSGbqG0Zy1Shuz8sPD/
         zXvzZhN1czxtB57x34gsmQrT4SZhgWxJbzypHGRpIXrjw1CPyTiPOzbvwOXjAYI2CbVp
         smUH5W8wBPlDbHRENH/nS9ZSm4qf9rKbfxjrTASnG/+tpF0DUChET7P0mmocJl18urhG
         Bxonek66Xa7gzCv5iLzhZEtBuZFTWNlpGfGpGYpkgrb/7QoVSOFKWb6kU2zESQrTfe5v
         srjYcRYqZW2UuN0iffN7ER0ZUbfOlOmlg0k20XvOgy1bZsPajtZcxhVzG322GyOl9Fqy
         06HA==
X-Forwarded-Encrypted: i=1; AKwUvBzPqwbELYPxqwvwQ/mOwjxsadbr7oeIETgOAXwVfCSIaWL6RLlM5BOF1ckqJQQRYb9QftcFXjcxydnZazoy@vger.kernel.org
X-Gm-Message-State: AFq9FYLdPZX09Nq1T5zAcWaZG25oDM/L/9itlE2t5WLRRWEKFEOjeL9w
	zCfYqBvDjkv6Mu7AnA9i4uKp64WhgkFMU+s/Q+kza4etNuF12BYR7s4URNqMSjOHOYj9j4DIvC8
	FfNvVdIK1U2UO8jImRk2ZUXXYujy9BMjjbK0qRjDL
X-Gm-Gg: AYBFou0Xmohha0RrbqU27oqqbwNgngEyBS6wAXbtillNn1L/ov/rkYNbz2PR0afXbaI
	i03DM5BLln1vS1abTcE+3cni+ftjFz/dU0wVmqF/CKDqigjzyK2Y+OLnxtt1AmApk5QzuFneMPB
	Kf8qx6Ur8EgqZRWirb4bkuFFRhsC1CWw+i545rHaVC77laTFwsw9YjMlujzrYPwW2bQIMpL9UyC
	moU1l/WFO2FeG5EdPA46JwnpD4aW+ZdPNNCOFUk/FapCXDt6Ifn2Bf5UoYAj0Fv078lmzyS1zq+
	Vluc7Bg4Xmj5vzPmKW6/AgyrmuYY9Qs5N5o1mzMSyhbU64dodZgxA8NReIJbHzsIZ3k6KYswaNV
	BbbEPweu1CvaryW0QQv0yOKIGjgfJw81TG28ryt6LKmwi4Fg58halvgFNmyJCuNervgBFPGc6uM
	3AZ/ngeOv82x/ZaPgf6ziibGSE6EDg9hHg/SNbke9dGEu75Ckad8hX/bbNtEYA9g6olTNcGl3k5
	jZnmRBQEA==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr943075666b.39.1793058727681; Mon, 26 Oct 2026
 16:52:07 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-11-jthoughton@google.com> <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
In-Reply-To: <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 16:51:31 -0700
X-Gm-Features: AclHuK-Nhf6TYTDNWSq0v6hReecRKBdo5ExoV8oZWGVCIO9BK-126Jv082Kq0QQ
Message-ID: <CADrL8HUZ3t8RdMEeBPfqsy1_1rN0Ty9B2c4iP6OzNS12te6vOg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] uaccess: Move the NULL mm warning out of line
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 4:03=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> > uaccess_without_mm() is inlined into every user copy, including every
> > copy_{to,from}_user() call site on architectures that define
> > INLINE_COPY_USER, such as arm64. Each inlined WARN_ON_ONCE() adds its
> > own __bug_table entry.
> >
> > Keep the NULL current->mm check inline, but move the warning into a
> > single out-of-line, __cold function, uaccess_warn_without_mm().
> >
> > The trade-off is that only the first offending access in the system
> > warns, rather than the first one from each call site. The stack trace
> > still identifies the caller, and the access is refused either way.
> >
> > Compared to the base of this series, with defconfig + KVM:
> >
> >                      inline WARN_ON_ONCE()    out-of-line warning
> >   x86_64 total       +5,884 B (+0.014%)       +9,714 B (+0.023%)
> >   arm64  total      +40,948 B (+0.10%)       +24,609 B (+0.06%)
> >
> > On arm64, this removes the ~16 KB of __bug_table growth, while text
> > size is unchanged, as a call is the same size as the inline brk. On
> > x86_64, the call is larger than the inline ud2 and causes more .cold
> > splitting, so this is a slight regression.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> > NOTE: This patch is included for reference only, to show the cost of th=
e
> >       inline warning.
>
> I would suspect that the growth is larger on architectures that
> don't implement __WARN_FLAGS() but rely on the generic WARN_ON().
>
> This would mainly affect 32-bit arm and mips machines, some of which
> are very memory limited, most of the 64-bit architectures have it.

Thanks, Arnd! I ran some build tests on 32-bit arm and mips:

arm (multi_v7_defconfig):
 - base: 31,913,726 B
 - patches 1-9: +64,816 B (+0.20%)
 - patches 1-10: +23,193 B (+0.07%)

mips (malta_defconfig):
 - base: 11,830,177 B
 - patches 1-9: +61,168 B (+0.52%)
 - patches 1-10: +25,881 B (+0.22%)

I think it makes sense to include patch 10 with these results; cutting
>50% of the size increase for arm and mips seems worth the trade-off
of only WARNing on the violating callstack. Let me know what you
think.

Is the increase even with patch 10 too much for mips or arm? I can add
a Kconfig in that case.
