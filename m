Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689925;
	b=4UwAaFkbovm+cLJDq/xWldjnjE45oj1Buo8yOC4l4e6ARRbS/l4IqrdY1GH9a3n+OyNx
	 fgmk1syMHmgNxPfzVHuAYNeEXva+39xX7Z1YLa6HYJRKrJTzoaY4QheBxNT6iitA0GkQM
	 R5LFdsyWBG7RRwtQenpuFzIucgdtkXfD3NtVYeg6OM1X0hsYqka3l27ahoosFo4ipWasa
	 wyqgGrB5nGXP7ZXSXEk7nmnyUyP3obhIn6uccWiBnZGIjAFcT1Kvk98aKalsfnNrOvMi3
	 xidsIe7OXJ00Jf+xR/dtFy5IEMv/jI8r/tpTlPhH1N6fUJ8pu4oYxO3ggdDJepCpQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
	b=CDWf8d8YJ9PWD2MyZGlVN2l/ZU7cksClQnTkperK9eFBQ03gDSHXu680ym7oiN3oaixc
	 wR3mzf4/lgNI8550PodwefTLJSYLBDvlIVZzVk9Lu96xDY/eWqlCDcmg9JPZnTNEzublW
	 pZ/XmmTms8lB0n0OI2EtrnOwjdNHfxBgCfT2XFdUD1Bad5iIKIey0DXIsYP0kFbWsrPme
	 xF0fVdc6LZ89YcF+78s8LngnXt7JaklO2IzldLtHvnjdta5jIYhPBm0/495TKloyYvFH+
	 HDUnBtaP2qpWUVGOQFVph4MQq502+g4X3PbQD91DNIiqA7Yz739EnHw/fbVpsxm32yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="fb/AnGuu";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7F606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 10:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=fb/AnGuu
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so4535182f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795689923; x=1796294723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
        b=fb/AnGuufRVSuumZI6EQLA6cj75+M3xYaDzd0Gy6RIfFD9vTufZ0ocvqMKbKkCMuJU
         HCBXLOxx8vgikybvFGaP8kOTEPC96KRwXnjjGdmpRLIAP3v7/cEX49ZmqXzavqZRuij3
         yAgWXhNLnFWVkhqNg9FhZPzLqKHj3vih4TQBrzWrYFpbfSQ4U8bI/qVviCwdNFG1GKRg
         Hxn6CMjZT5DpBlzV5e6WnYlgdhQXs2yNA/UJVS7jWkPiOHnO8ZNEWlUFaREDrgmI9OpC
         SZzobCPy89LxilfHUkDRa5QJboD//JYUx9AJLoSKPUrVgXCRpyowQ5xPdH3/qHs9I8jV
         3Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689923; x=1796294723;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
        b=YwbveLZ+kOvuYFp42BMg8mWxXkvHvbg5WFpf0q2wUMG2GTh5a94gnzUBHw7jtGf3gt
         xSbrrrDzUUyhel7eJ5Bt9BtGXy4QYy+VXfeSlTqJjZqPrsCYqcsChzyBpPxjThtsSind
         XzM7cPpvj2Q/NecQjEHt9/QB7iLAuJvD9ocEgyJYc2N+OERkEcaxrGy5rDZZ0/VWeXoq
         FlFyJyTVdCNPdsvTN05rIxaSKPL5yNbRUR233IMldd7IHbt/dMzp5/SydXTUOqH8lKBf
         OQpPpQWt0luhK8tHMnn1LhPHIfrq3YMIzCuBHFZpVE4e1OBMKKIYjapvWEwuwYYwigsl
         FOkw==
X-Forwarded-Encrypted: i=1; AL+hErFckqesa8LHzSm7RsnfaHDpJbUZtxA5I1DKzZSc2L8hWYqTZStCaYt1zESG5WEWtihjMf8V4HRTmluz2FCh@vger.kernel.org
X-Gm-Message-State: APuU4Z/YidMnelIrAJoUj0UQGcmr51LZ09KcdyGaRGA0YbSoec8ghKfk
	n1mJH3Orlrv2p8Y+ulZKK0CD1HmYvFCkb/Fmfil8ZswNNFRdYfrWWdXC4SQ03SY4gRs=
X-Gm-Gg: AZFdTZfIFYNUS0qJypFe2jouWZcbh9LrnjMGaeYHV/evU17huxtWs1RcNDUpkwoWP3d
	s0cmvaGrgea51qV6Cg9a82kVWrJSoCahqf06cdrMnumXC8z0lix6Gr5x57YRVDbWCHYJzHeBnA/
	aN9PJLf0Js2yg85UY/ZipfMgbk9tjNj++YWpSwNxxyFKnMyn+92CPyV7zhDoUXWBaqQsxVmf5Rb
	a2glirCYU59/JRg+GDfNHtOZ9Nrg3TlkCN2TsnlN1APuyK0Pwjd+x7f1/hNDrYXxdrCG+am9rCZ
	F5FL9DL4lAbsEW5zMC8IM2ui/9UsIUT2PWY6/JK56+R80jJ7nKpVoE5m+jmBVsQMI50q2HZCVD6
	oshljPY4YY1mtkkju11FwEMDkInYdqAzOKzZV+Ceqo+NX3Vn3+n1l5F1lh0bxheQ5WYzVtdIu6s
	xOtZrwFx+lzrv+2tqSlAIRFeju9ICSl7Cvu80bVMALCI9BLDhBL4SgMf9yHpemeULCsF2i0xSWC
	rbZfYiYjGU9tev72XkBaKiODlbkqpjeBjQus7gh9YS13XeKSTJWHIH6Octi1vFQ/EgI2X8WwAts
	mBwWl2Yi5CXn2uWf5pOoN+/VVDE7HDI/W50fBEZym5sS/5KYJY+YaCNt8KOnon5G5w==
X-Received: by 2002:a05:6000:248a:b0:487:b50:101c with SMTP id ffacd0b85a97d-4abaa97702bmr38359967f8f.5.1795689923186;
        Thu, 26 Nov 2026 02:45:23 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm40416103f8f.53.2026.11.26.02.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 02:45:22 -0800 (PST)
Message-ID: <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
Date: Thu, 26 Nov 2026 11:45:21 +0100
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
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 David Laight <david.laight.linux@gmail.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-14-wusamuel@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261113221248.3535369-14-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 11:12 PM, Samuel Wu wrote:
> To find a few kernel symbols, users such as libbpf parse all of
> /proc/kallsyms, which is several MB and text based.
> 
> Add the KALLSYMS_QUERY_BY_NAME ioctl. It finds a symbol by exact name or
> by prefix in the entries of /proc/kallsyms, with vmlinux matches first,
> and optionally in a single module with module_filter, or all modules by
> default. Each call returns one match and its position; pos + 1 continues
> the search, until -ENOENT. The output returns the address, the size, and
> optional name and module buffers. A buffer that is too small gives
> -ENAMETOOLONG and the required size.

The kallsyms data in the kernel can change between two
KALLSYMS_QUERY_BY_NAME calls, for instance, when a new module is loaded.
Should the mechanism provide a way to detect such changes, likely by
tracking and exposing some kind of generation number, or is it
unnecessary?

-- 
Thanks,
Petr
