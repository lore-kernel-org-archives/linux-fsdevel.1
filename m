Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307124;
	b=h3tVcYlO1hKW/5cc8u6Q6tMSkB6rOFB7417zf3eUTgFlnlbBE2SXiWnNk0JBpkhPNTvQ
	 wwfYWEe/YqPJNOlbp9kR2PtX/THzOSrdmjGbfTMA2Vz2Is38x3eZmklP6Q0nGBVzHmDNf
	 xzUUiPsYBtQfVPUtYmUo+14qW8rtW5ODgIpGhO7Av0STBAoT1YoOFQZNAHUTbKUeKAF29
	 krQ7ZeDgszPuEEwymYUFi/V2w8IsOS7Sj0DPTRpO/sWcpNMGwXrqVzg/zCu7mHXe5bpEf
	 gX/WdBHwDdzzkTgK7MdyMYmbxvX57viWTC4Ve2aeTdkiOPkLNjsEnbnDl19p5YeDLmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307124;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=b7RsvI0hOcJh521Z4xHa3Ewqq2iR4xhkA+9avBbw1hw=;
	b=i4rlIUs7Hc1pHJc6Edo6TlVYgfft5bxMJQvmFO99VP3FeDAe/dZI5B5o1rCktxWVKO3X
	 tt7MeF7Y8d+sGaq+N1nZ66BYc8wvvYLDIxGptoo+9Mj2I8PP5IF4jUsMezWYGzsibtf8B
	 qQtajQ9YzrtrjIxspV7nGCug6j20i1KkuDpA2JV9Ncn/Cdd2PM5+vYKGmRKg30JrKm3Ck
	 OWVdL54uZbGNLKB2laiQK6vPg9+rDjimCtCMjd4WiOF1yb+itvSQ9u4MHLnugFAebGe8B
	 2VJOLBLpQ9oK1zK+yBngAjneRab27kCT52pH7Hb+fnPxBgFF3FT2r5Vdp5UJS0zJ22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.108
Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901460A2621
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 20:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5901460A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qSCjsS16AB3q8ughFksRp3XE14xTUtnLCcAS81y8Ffw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793307113; v=1; x=1793911913;
 b=hDORIKKmBWP0trd3rmpjTQv99sXn0QVwShDvUCQEMBt8yLrqGFOqxazWtJn+1A+J69tgGShf
 Y+w4cmxsyzfMpW2wXixSe0VtPcFwA9+c7fSVs9PJy7TSAV+qCOU8C3roJBc0P/m2q1ahL52dmSV
 eB+MwGe1IjA2nKKdazKWfaco=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 12e923243a9eb27a;
	Thu, 29 Oct 2026 20:51:51 +0000
X-Mizu-Trace-ID: 12e923243a9eb27a
X-Migadu-Flow: FLOW_OUT
Message-ID: <3c020a05-5023-4aa9-98a9-b9cd1de3b2ae@linux.dev>
Date: Thu, 29 Oct 2026 13:51:45 -0700
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
Subject: Re: [PATCH vfs v3] bpf: Allow bpf_d_path() from filp_close_sync()
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Jiri Olsa <jolsa@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20261021201400.5409-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261021201400.5409-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-21 1:13 p.m., Ihor Solodrai wrote:
> The d_path selftest closes its descriptors with close_range() so that
> its fentry program on filp_close() runs.
> 
> Commit 056069eb2b66 ("fs: make close_range() synchronous") switched
> close_range() to filp_close_sync(), so the program still attaches but
> is never called:
> 
>    test_d_path_basic:FAIL:close trampoline for filp_close was not called
> 
> With that series, close(), close_range() and the closes on exec and
> exit all go through filp_close_sync(). Few paths still reach
> filp_close(), dup2() being one of them, so a program on filp_close()
> no longer sees most file closes.
> 
> Allow bpf_d_path() from filp_close_sync(), but only from fentry.
> filp_close_sync() drops the last file reference inline, so by the time
> an fexit program runs, file->f_path may already be freed, with no RCU
> delay for NORCU dentries such as pipes and sockets.
> 
> Attach the selftest program to filp_close_sync() and keep triggering
> it with close_range().
> 
> Add a test rejecting bpf_d_path() from fexit/filp_close_sync.
> 
> Assisted-by: LLM
> Fixes: 056069eb2b66 ("fs: make close_range() synchronous")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> [...]

Bumping this, in case it fall off the radar.

bpf-next has the failure right now, we apply the fix on CI.

