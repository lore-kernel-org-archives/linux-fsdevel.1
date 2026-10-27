Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068958;
	b=FmQlk6gT6ayScbQ6bDcqX3jZsz932zO3phz9oK8EUnoCEBTmnRm55e4KEOLSg70lccRw
	 It34aoO6sp5DQ/cO7Sy8ShMlRxceeS37sUYIxjnQs2NbXxsiwExaGhmgE4nZNTYl7bbpl
	 Kyty0yN81kBtJGduIzL+On69D2eBo4k7eblu8wrnNf9IqMWyLA6TDnsT6xrQ90AJH+FIf
	 Q2pvSWu4jgDfGNz6395PX4r5tp4/K4b5w2SOx8ZD6BbKOUD4b+9CNUQ894B2YK2F7K6mb
	 w1s0H+pIGrGtl8zlmfCMwhf2EfTkIbHYgTFnbm9V7R5coB2Fq7uvFrgutpP2AUADthw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=MGhPdCfDmlYWh4Q4bltd+AavKwzA05TzxGhYfSZQGOty+AThIoMGktjscMKqeK+ieDHt
	 2rVxbCOih5b/M4vJ9vdwOxFufJ6zIoZbPhLUbZB2WBtGsIJ4J9x1U20lLHyM32HOogb0G
	 hwvAQtYXNpOqJzhmflqWqvHjGboYz4kOnted6S+PmdTGMz1HxV7iDbtBkE8e2ZxKloGae
	 gHeKqfmUXWhsHWssGipa3G2j8iZ49IOO6t+oXlx91eauMpBZQsfU/afz00m9ar44aqJPm
	 JDL85to1KeOOjMalicfbhYtLlY2duaa7LnOmwIN+osNqfcWOpx3rZCtudn4td/RbruA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8E606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 02:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C8E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1846bc43c28so4071748c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068957; x=1793673757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=nAMLJ4pov/UKnTCLgH305UyFiee1Kbb1n3tCzOl712VaepOkFQaBHOfe8TqG3p1lZU
         FcmqVqrrqUreTloBdzXh9C3S8RzvKdqK0Wdm3ymTtA2e7F8hg+g3tAXi0qMz5tjjKhfg
         XZsmI+gaR0xwl7nmIQiVOSWVXQuFdQ0nDSV/JTrdP8vh+zCmGEp4ByKhGzO7Q9EFAqG7
         Z9UxSRbzl1SyjYddPBfqeotnjUxiWUf5QMQHMI+2cHXwFS8e7Vcd6faApvoLAEI8hyVq
         H9p+0vB8HKXlTDO8gBcIdyEeUOqojMCpKudjjewsxrlbiMp0bSMq+X14CJGfZa/XuOHM
         djkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068957; x=1793673757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=FbRgBD+9NDCmX98FTn9XcXkqFo/X7j/fZWlQxW+i9tCHJJ5/mRKaFwY4UPhlFv3VwP
         uusRtLXdx7Wq5NPKebP6zR00oGXZJjnCfoPXma+9CEnaMXiLM1CWNfC6A2o6sSvm3/x9
         1RNrdEtVhjHGyrbd3X1875UD+cKMdHl7xPkQtEOqxu7f0nJrJXgRKdEYPbEZI3UokLHQ
         TWF+51iC5QmMy2mi3UamTMRAox5WsucfWP3WiDyKV8scWLWxQHhk6+0plAS5UlHrnSuo
         uYUG4/IAZwCZS0vAF5k+aUNf9gaVIAYZkG+S9f69zS2MrwQ0I5743enFlsDWJV9/PJ7C
         YSZA==
X-Forwarded-Encrypted: i=1; AKwUvBxf9SSja+RB5ank97oTv7piAlVK8Qd4HBFH29Ms2k6j4OBXYttE+oHG0q1eoGxIr1+3YZMtBOSLCWJ1S+3P@vger.kernel.org
X-Gm-Message-State: AFq9FYKmlHVRvfqLN5BfGlf5F/LQWG0D954Ydwo9XAV6wmaPUw+3nYbS
	+Wcm02adgystmDUqtrnoc+UW6l0dJZ4UoJOAheuK9r7kjbus6jMznyvvD0kqnScc2wA=
X-Gm-Gg: AYBFou2J9QPoCndDvXxNgs44J/YFe6zFWHAwzxsp/pbHXf49Uu+ElaCGFcKjLJuJije
	Djz08G49RzlueOEariNdu1x4A2EoCvRbn/qJgsF/S1UStgl+7wbxe8Vc2UQvy/he2g9kfKyaHGx
	mB3LiSMWGjEcatJvOc0HzrLlXX7FemB+9guZyCrfiglLqknuuh7c6j0MvmtQYfdo998BqJ7v2S4
	HN4cD4QxmtRhF+yANoactnjFCC7vE1Q8cEE8KH+OJhXuShxoxGdR23RLifnMACYwwKCR7C1fz9Y
	jM7qWjS3QEJm4WqhVv6rbgwvCwQkaRx0s5zz7tce2Om0IO5+5fEbv/sMqRuSlaVxfsoY38V9EB9
	T64b8mGxdgspynAWG4FzCcFW9bllmbs7nxr6dsVNjUmALFNlbrl20Evxa+rAQOKLNRbIDDxiczJ
	yCaVvqTsPfu6gBVy75jQNEWRxMcQClTOUrf8/ifKPvXr2l+FybzWeaVA96Fw4ztOHc4fBh97fAd
	GIkPmj5JZiNhrL8Zk9SV3EqZxKcEJDq1OUlOQs57OZWxL4TWdIwnPWMmgLBm6bn2Nn+xLA1uFgf
	2OD7yh3qPX6lSCknAHG7bNcU8JrZYlE5TQcfq8k=
X-Received: by 2002:a05:701a:ca07:b0:144:fd7c:84fe with SMTP id a92af1059eb24-19937307669mr13761314c88.35.1793068957501;
        Mon, 26 Oct 2026 19:42:37 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm59514670c88.17.2026.10.26.19.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:42:36 -0700 (PDT)
Message-ID: <30b1cf28-61e6-4f28-8e28-79815bd87617@kernel.dk>
Date: Mon, 26 Oct 2026 20:42:35 -0600
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user
 memory when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-3-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-3-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

