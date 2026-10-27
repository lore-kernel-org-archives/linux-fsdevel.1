Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123600;
	b=kYzyOX5p56wceLiMnhuoUyHIsY0Y+JGnKH9U9r2WlrLtEmjA4XBEa1eLDlYehYEu8Jm9
	 3VV4A8AyUhcWxrpcVxPmaDOsat1Q2HuAXYLCHiHm660kJ1Ellkhh4cJ4Kee7tfMoOgdkC
	 Q9vWC5ha3C5ALus7gnB3aLRRNvS7kHu13i5mkdjPOK+ewzHXHAQiP8S0kGj3/A2cU6PWS
	 1t21gimLwHut36/hjWyOUEPwKh3fAEGuVsYu4HFKRhKRX5WhSN/IPxArRZ40a49Iw4XoC
	 emG3VKgA5mc/Wb49WVOIoeh2hnRnkdzh5ETOHDjugauVhPQ0SqWdQijGwKZ4lSW0Rqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
	b=ZwCyrUfaJoQWux+V6kVSh0qSo3xqmBJgxtEM3S3Ml2dId8rHYkNSYrhXtfQyOZ+FxgN/
	 ibjMShMzdTfdx/hIcvdfI8Ryz7ZFRsVByXX79NCNJ4ALpTPFoWM8l6O2VRYPMwT3CubrS
	 YBcKqigJzv4ufnqkMT/DwkCs5yIDJkCWQfJS++EqurRVgl9Zd4m0gss0k0W9S+kRrW5Tg
	 6IHHAZ1rDucKzUFRCpXce9uIeoxCrvrHOHGLMzNRCGNV27f4vo5FnUWE6+mOrjv6d8zcB
	 +kN5FDp6pPMhw+deqYtWna7cf3FL+UB+8DUQu2DhY4++LuZbCxB1PzzIt/31fWN2/Zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF05E606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 17:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF05E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=inJR6ox6
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso13487766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 10:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123598; cv=none;
        d=google.com; s=arc-20260327;
        b=WzCZ5yTDbUIl6DBH8Czf7hnVYGXrUi/froc7z9Nd+iYlGoIeuId45+5WM1qiWBhpSC
         AXX90x+bKXHtL05e4f9C0dxK+nul7E4MdjH857vGSTpC2zoZX6MyW5g+0P2mkoeK2T7A
         FhuVUI6TSlMb5U/USI5iiPvt+x5Q1wLvvPj359TSB1NMyLIILfEJmnDhhP2PY0+imMEf
         MnuPxbxd+8r/z4hllxFiapTs6cbFVGRL7P9BYbLjFfILGp9BhVjX0QLeXUGUQg+0r+Nq
         1YK9KzW7+XX+bIWA9WGzMb0IChU5Za/geLqH6+g7UPrYGnBz6RL+PLsvyeHTFHfmpb97
         aFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        fh=iABTt/Fo5i5egna0R1UCoaYiurocfft01lebv3PIAOA=;
        b=SrDr4I0JoczinCfBQLjA7/ex2KGBg/ZwGFgeGnWBtVYtShMAy/IS8pPdRIFt14Fx2q
         zYl4nBg9NiOmIg5bPK2cuF5ErOD+kRDp6hs9DBeROX/WE3qK85/H7Zo6aAn1UNHw0tQw
         y/0M/zJq+eFIoQQxXu2LKlWmfhgJv4qdbDbObWmIp2d1hhBmo+YpSskSyO9JfOAdWE8M
         +01YDmNHJplZuB2xCgtPvTKnGGh2+IRDVRC+X0vG6V07kxIke5TAF9qZp/YY8OZFSr3q
         lH/oFsi744SabbYWlwXFT7Pf2rsmFDP547KRclHZjOa94+cWJ/ALF9UjqIso4WSv3Uoh
         D5Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123598; x=1793728398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=inJR6ox6aQPgzkJ0wZYiPBugaLW1/kUDoRUxznaXNPrxE2Wn3DkQl3afONPaEwO9sl
         vnrt6FP9OFfRf9KWlwZNng3ZlaCrfp3bQxPXGc+Gx+AORrKLJ8WZpN9m6kJEM6IAqHPq
         Jk4iMXPxJgkZqxRsoYIxQcD6CPbdcJbwTT1mEJs9Oh6VfooqjmJi5DvsYqRTbZ70S79m
         W2gdT7rvplj4k08tnzQQgxgOTLo5uqZ4a0mScYBLYVaYMXTVeZPwvd3azNIWeu6/sXO8
         zyeS5P1gD5N0vXZJTHB1IRGypOyTZEZWjLyDPXDDqsHxY4MhwV784zCuBQDBJ99Srvxy
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123598; x=1793728398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ7BfEA5+mgPjgQ08MRW3gJSoX82BS/9Z3gx++ZKTBg=;
        b=EUupC/odSqq3ToMMH5kHxyWuU0BWtJTjeSpZCuXK5MWXhS6k+vaRDgKGaTkRiO+twv
         h28s5tVIFcO+t5KKLr+Uz66IjdKwKSJoZDi/2CxLIBTuJRC2sGW5do3ppduEEbKgL9oA
         8Ap86COOqayAROf5jZKce4brvZaB48VmbQFfcSl8v9t3hc/zj5l5nGkKV5Is4tx478w6
         vcB4P6YPVkMZrTMNciY+JCfJGYQSbl5m+awgwRCxA/6IXuNmmA7oDde2+5OMdXicQAYn
         MhGPQSEujl5AfYK2wEdNy7Oog2npisfUzby7bOpOoBD/4PoQO84NZQb36N+mFtREkejd
         4nSg==
X-Forwarded-Encrypted: i=1; AKwUvByHzlYLPxGBlR5lCA4y8VFsUXxSGxkWpqLwn3suS1X1JsKY+FJKjyAdMCdnUK81zQBcgQ5fyn4O+FkgQA/O@vger.kernel.org
X-Gm-Message-State: AFq9FYKuUS6aCzZWRiTeA/faSj2YzMDFUsU/uO1gA0ai+UvHfME7nP3C
	0q5qX0fIFEf7/is1wvtsbZPtDAu/7HGoTSSXdG/JDa1xzg8SDu98552wcXIA+lGCzWAR0ypwCRZ
	LtLqL6OLBjEhL7biUvmDJ1tswXYVAEsh9HqBF+vQs
X-Gm-Gg: AYBFou2tbthk+aaqlAhMyrm6UWKlFM6n0kNUd8RsGnawyi1sUrZIx/ZlSACNJ7Jarjj
	8tDvOQUFBPLzftKcXFqZwm6wHQprLOKNbS9LjMDx8cNfoAhSPb9wQME2LYW4FLu1V/pyfjEOckg
	TDdYnWzD1Kh9JPn+HJpMmzxzxJ0Ypec0U8QAGr3BvswV87yUXxRacDeysxJenmNGH2UV+2mX2Hq
	eT2To0KWRn/ohaKHof5GzJmHen2MdYKR9wCeshNFOi7/yLainm6DTY6gXY+deMJ1hWsDmXgGFG1
	FdW8dkVVvP7Tf5TZphTYCJHTVi64yhpjr41LB1BwG13oB27iu+kC01Bt2xq83bBPf3DVBgDq6pG
	D/Aoi4pj3BRGN2EoP7OtHs27N6RObkdQ9x62zIKAL2E474ZQkdB0SKC6OUy4lyxiNSFomgqLxcH
	ghXeNw0Ha1Jn02K3y4mp4gVMqMrQQ32aWhpL5Jm5BS73ZI+FNtoRd4uKavbuT4lrnv5PNaQaFYy
	/mcwuhdawH0Ug==
X-Received: by 2002:a17:906:dc8e:b0:c31:e958:408c with SMTP id
 a640c23a62f3a-c46bde8b464mr1159692166b.38.1793123597614; Tue, 27 Oct 2026
 10:53:17 -0700 (PDT)
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
 <20261026215226.3713941-2-jthoughton@google.com> <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
In-Reply-To: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:52:40 -0700
X-Gm-Features: AclHuK_7gnb7g4GjAy_SA5zcAxXhabVZixR-oCAtO-qS-tkfEqOEG_LlV9pvyY0
Message-ID: <CADrL8HVgOYb1hzWDJzm4sCrEAR7PL1xBv-1zTGebTusPoDsGXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
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

On Mon, Oct 26, 2026 at 7:41=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks, Jens!
