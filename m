Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75E466B58
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475278; cv=pass; b=XFXWEx7eXDdWrWTYFjYPLLyiNmirhqDjR2tT+kbSUonGEl/8rAf6u0e71V0vi1Iqni7Ip29bHKfIawy55yNIbLjonHvufOXF8h5oDl0OEMo0bZo37sTCMuAwb+x4nAJ0TZG9mfLLgc5P47IlsV4zx0pZDzcNMkL+eZGs/KUfCe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475278; c=relaxed/simple;
	bh=C1hreM4FHEoohH+eGJumQkjd/LtpSUCRmMU2uj8Ja0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLCFYu0vWggTlkAn7ZB5cLXnbnXUjlGQ6x/VRbx3MiQ4k2G9MmCB4UW7VLoMcRysWFm99vfMj3MotHt9QaY5W0P1lnXzT96p4UoSJoZlYmtZ/RaITLVlh97LOjEpdz7YojpNp9JiIzBfgN33YS3ow1DzUefMasKHevbmatBXQMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f52Q6cZ+; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f52Q6cZ+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacef7d299so22865ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 12:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786475274; cv=none;
        d=google.com; s=arc-20260327;
        b=jiATUj9TNwdGfmBQMo3mBISWGkA9UPQnHdo85ABaDIewBvFUjPwV5D+95Jiz7R36Dj
         YNs/E9rvzis9KPoXH0s/PztUn7td64o0LPuPNEbKcgqPuu4GnIPXEQVGyQ3H5mxHUI9q
         mhvCQBbCwoUN9HFLaouWOpPEeTlwSYjJcO5HlL8VJIp6IqFaSRhIGHir/eJhL/450xlm
         5jfusUR2ZbVUz8YHVyWAhM+uSED1ficmnoRPmJdt3P1aRO4pAogYSWcNtJubsP94eNib
         ID+ja6Sl6lBET9bwaB/lg+XltqesohudUELanzqAZhd4bqKgtMouZspDi8GtUS1X7jOb
         knwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1hreM4FHEoohH+eGJumQkjd/LtpSUCRmMU2uj8Ja0M=;
        fh=gVRqdwdwEnhC5KImVgj3JOibPpV3ANOtVu51699cNCA=;
        b=iMtAwWaMaD1YXg3lBGStpmycUc8gVAzeH5wuKG/RU5tyj2a9s+wX25pIpbnuVRpolj
         +n2nZ2E1M4wLAwHpPX5U7wVvq8NP2Pyxyg3x6xgj+mGprdNCE1Twk49xs80QtDDA9Dxs
         knDwSSbPrZdmtBoO1w4+1fXNu9cJs27hsm/JlOJBuSomma/hlus8MPFdAHEpr5RYjiDM
         Lov2MdeIquT/qgRJgeJ5kVUMyN7/sydPAef4pajVFuUN8ky+WnEYbq1GRoKpTBXy0VRT
         QFjR+N+UClTtT8eLv1FmTtFgg5/qdqmFVeN0FR+ti08ToldYNdQ8ovimYhOJ0ogTs685
         BBpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786475274; x=1787080074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C1hreM4FHEoohH+eGJumQkjd/LtpSUCRmMU2uj8Ja0M=;
        b=f52Q6cZ+pga+sW7FR+YhQgyATx0vGbkY9yFhTJof/GW8VCujYo3OQ9f1omJuccegHZ
         52Xm451BQfwvRnU0k3mpvbRtGgHaFXM+4HbiLD3StuwkwSUaI8DncAz6CmS/M5cY0EnE
         pzN7hcYfAyqCYNfokleRmnMie27iOCqIUFo0/MA516Xb9bYOaM9ZB5xlc0Thf1BDkR6M
         Xv4oiQnymXumR4l903+9cQwKiMxhrRjz690VdOWgq91JHYAjiqWs0dvcGCGTW7aMxRX+
         thvfs1XxLMGjiEO/QYgoIPuftMRmLVpN8u47OIM6PO2DkJzXde6jgxlMrY0YqfwJviGW
         A+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786475274; x=1787080074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1hreM4FHEoohH+eGJumQkjd/LtpSUCRmMU2uj8Ja0M=;
        b=jOqUErZIVi7a9SZv/y1ArHl22FFcBUovocqEyyRtjyGbCBwTGQs6Y74iVq8bvV9cob
         /HMTNgoL7TEFwolJyheIMNSakJZgMWxmSF0V06moA8uMsRYyoSACdgCifvRCpSulSvHF
         RGMIlvGx5pzghVdX6b+tHXHCQxRSRJYm1mL5cm2Zz6Sh08zs/nFBTqV9skAJksfVzF0w
         4zs4ha4xf/Gdb0MKCK2iH4QMZWqMsl8z3pMiTQ24TBZrIKTmKqVYEKPdSQLaPZyHGRnl
         juQJOlKIMZTqHpgqgbkrmr12yqfpamOvi9we+3PPgdwH5XKsOiXk363TpSUjJhtb+zIt
         f52Q==
X-Forwarded-Encrypted: i=1; AHgh+RpEBJ5gyzOMNN6oLUE91QFb1oc0JPCk8btK73jMCS+/EVU2RwJhVIus1WiRimRgMccCIo/4uE7C2metFqXe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj17uW+ypmvA1I4aRk59SPxzmPE9Kd2qNTcei1RZGaCS3mDZNo
	vTPsu/eiGugoIk00oUdh9JUm1ciSfvQ3NC+J8uywzcQ42geJqLZBGthU7mxpfj3LERPx44Btnx3
	aaJTtUu9/Ae3a1pitdcwYb7ryk7kx9CCpTH7n+YqS
X-Gm-Gg: AR+sD11qUTBpOR9BPpwVZSFVIuo/WG1l3/xG8fjmWFbaeIQPxnDg1tiCTOC1FZVwiry
	/QrXsiSGlZNt9bXDbG8VslRIqa11OPG3R135SqiO0SSyPlLSItArH/wwXrbnIDir33r4vMEQoMz
	IB11fELbx65Br0LxpNZZjHlnKK+6T4+KiWWu30i5jjQMVxTlRNPPUNlbUPUqTVoMw26/gno8OAL
	GBMPYyquSVtHGPwfDNZRK/LKP84R4qqK7ZecRj0exPwOdEtEYA47oUOPytS1RndwmXh/sr5LGsr
	kfm4VdDu0bfod3KAYuB/5io+MlCPgtA5abuAZ/ron/R7DTel3/iRhioGo36WoCpymmCzqF9hilw
	+h/l1Q3l+jKLLwDLz9O5JtombWHlGCKE=
X-Received: by 2002:a17:903:1843:b0:2bf:3579:cdaa with SMTP id
 d9443c01a7336-2d33a99905amr481575ad.10.1786475273937; Tue, 11 Aug 2026
 12:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 11 Aug 2026 21:07:16 +0200
X-Gm-Features: AUfX_mwl8D17qLmpn2j9POaLRIWa5xMeaCP1oLEBxMsBs01SgCKLca4ifFR7LFM
Message-ID: <CAG48ez3QwUopEyfB0tEc84A57g3GZdnptazJW+htiTi2e0Gc=A@mail.gmail.com>
Subject: Re: [PATCH 00/11] coredump: allow to create sparse coredumps on the
 coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 5:27=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> A server that raises COREDUMP_HEADER in coredump_ack->mask doesn't get
> the coredump as a plain byte stream but as a sequence of frames. Each
> one a struct coredump_frame_header followed by what it describes. A data
> frame carries its bytes. If a server also raises COREDUMP_SPARSE, zero
> frames are sent for unpopulated mappings. They only indicate how many
> zero bytes need to be written and to not include data. Reassembling the
> frames gives back the same coredump. A debugger and everything else
> still see an ordinary core file and nothing outside the coredump server
> has to learn anything.

Hmm...

I think what you're doing is probably the easiest way to do this in
practice. I guess some design alternatives would be:

1. (overengineered, not generically useful enough): If the transport
was a pipe (which already has the concept of different types of pipe
buffers) instead of a unix domain socket, we could introduce a special
representation for zero-filled pipe buffers and some API for receiving
zeroed holes through lseek(pipefd, 0, SEEK_DATA), but that's probably
not sufficiently useful for stuff other than core dumping to be worth
the effort.
2. (somewhat overengineered) With some refactoring, we could maybe do
something like /proc/kcore and create a seekable virtual coredump file
that we send over the socket via SCM_RIGHTS?
3. We could leave the userspace memory dump out of the core dump data,
and let userspace take care of filling out the memory contents using
/proc/$pid/pagemap and /proc/$pid/mem? That would also avoid task
switches and SKB allocations, and probably reduce the number of data
copies involved in this by 1.
