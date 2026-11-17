Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794885328;
	b=A6qKZw4vX7O4H0g/UC4Xq67bw5SKi0gNyKteDOfjkVXmMyAaGszcxDukf/KO1IHdfwXS
	 uDt7ziQR5hNQOuTbRDtkjPgqdmdaCdbkrA/CPDP2K+KV4UyNqCTpTOxqn62ObiIEED5Uy
	 wmLklp5TLb4xvIgm/PI1RN8rZsDZZEFzh64+P9ZB5xBrHNtccfVWuUwiaGnQjx+yDXU6X
	 TOA/qE5k3s3rbiw6VENK/I2utfOwgWat6XwIOxyczkwfk29RrQgsL9M776Qtz++tbYoKW
	 TWfJxI1jtGFgATX9eUGVH4DaZS96wT+ED+uITe/HWqpukGskVs10O/2WQ3nOwir6ERA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
	b=rLlDstZvTXzF0+SVz2Q2mXcJf9Ix7rW84DC5lgte6eSuBqdWZi/8VWyfrS6wkmdNQVNU
	 0l+rHxm2Y/Jz2jLnEVG6HDwW50ayQlODBXkZasjcCJvJeLilP9E9T7buHEwtoGNR96lw+
	 vcQSOdI2fnr4VBjfNWGCJ0WNRy0Auuiy0BOOc3FRJun3rXTDi0LKkuyThDNg4iOjGKUdl
	 KTanuzah7Df0IpkgiE0GRCm1ubTvgoFPCourpb9sBb6T6qMZ61WVToJ7kvdPGHJCImnm4
	 ioDZW6LilNW8w7diccQWyuxGIMlrREwJoXZTvINGkiepTPTztqxiqIf1lfODyjqHTjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWuE0zna;
	arc=fail smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD6606A330
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 03:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51DD6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWuE0zna
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40f29667e6so734130466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 19:15:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794885327; cv=none;
        d=google.com; s=arc-20260327;
        b=o2axgsJIHadgSFkKf5QetwUXk0Mw3RT8CKyNHax/w61sR50WHrUNu3cxqcYUWinZk8
         2HGZAF/7BgnOWGmjWthLf3EUcEDn645HL1UV8ci7av0WINuBxA3wjGi9rA5wAfElkWrr
         SbJWPOkA3Cn3nK5uYqviZurWsOUVVfDUXga1LZzVc4suCfO/oRaTY+TV4FwJU7r22wn7
         vPI0QgggunjW/nksKae6IddGUKzg9XRk4zRnEkmwAPURTXJ7SqEiYzamqw4h1yQX1Y9e
         FNieC9EMjjxmsUs+L6GNiMg1WUBRiEU6sF1M6iXUorJ0bqoCQErp53DXgP9u06m3Igf7
         HbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        fh=5CW4JqTqSc18ptqWVqdUKEqRhAKxJZ6CqKGDZlJvqrs=;
        b=VRIOQf1uvRp7Oa7Env4hlB5M77FQefUold1Tp11NZ4GVvgkcjyhqdreSL+v1qZm5Cj
         3rVmfEpQ/I6+DDVScwfA3ZBoLc6Ep4Jb1qhUEwuMowM+lnBZu8KI4+IKu1DBwKvTraPr
         07h4kbWlPZHOXLFHc4W9KkfLtsncF24gaoVmaD8W1mhRKq0IBpuJp6XhNpox8aprFMhW
         Ve/lbjO3miQwQeQPQ8nYeF1X57ylFW35gqXBjQGuaPo4vUuIjfGFNoAnHuOcSvh/rEus
         HRwbf+y2TQNp/sssqgEqkEg5PJFB7bL2FTkiT7ReALbXtALfcDqL52/xPkE5MvvCBo+B
         7uzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794885327; x=1795490127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        b=UWuE0zna/Kej6vRfmnnkBRPiB7MtRAOmWnZDUwfDZnARnTtWa0lZ918fHjZc6mu5UO
         /2+zJyxEYftdneZsscW0DL8Fvl081Y38tQO4Pv5tUIPYfcIIYe6CjwGLqcKBSst9Gk21
         HyjrRa3A/10hlqRod0LbCztyuvg1+0RmyX0gzRFwGRR3oqb5tPu6tQU03asd4m3tC1Ly
         2jBUNoTFraXXJMf5dSQasvoZ/LajiRGFP3fxeQbTALoTqP2ZEYO+PCEtWNT6HsCG/4y2
         Qq35/dZdjfO2Tkf3aMOsAIjY43RWuC/9l+8ADKlIptRxOOPmsxJVEZSYuAL1Y41KbuEX
         BlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794885327; x=1795490127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        b=SIs+8a+tPmBKw+gb9oXeUuGVVXKCW3jLQkaAb5DsHlQ96ho4KAjnCCGcez51XNDV1D
         l72OT9qz0iCUXOB/8l6i/HDmiiWhjqUyZbaGUibFw5RxMU9d9tfp7TsPZr4mLR0maCLw
         imkLGZri+nDKJJksR8xmoiOdt4Jmtb9B3UyON8ZSdLmctwyWUoV9JQD42jXKJdP/GzcK
         DwrWF23ZidHkjLVqU/WkRhftcc1haEh5N1mt0Tr1TAqOJHZb/V5FW617TrjcpS4/+mLR
         Vp39jumhD9otxxuQTjeCSVC6S3g34hAEcrBolCZfVoXJ7Eq6HrSlut+5tu5Eko329fi9
         eySA==
X-Forwarded-Encrypted: i=1; AL+hErG03D0WzkjUlz8TwSvRcOrmdAcFSsR18WVuoiB3D6JnGsHTS6MstLOlYqE8ReumS0Ue5s8nqHgk1166SyK1@vger.kernel.org
X-Gm-Message-State: APuU4Z+gXPHCb6eKRTLJ1yX2STzbeGNzdLbmXnFsLsrUPnVbmdKbUJP9
	bMRjSQN+Ck23i6PFQ1MbuZ2EGaBMcxa7b83dE2eR1ZiyejU3N4P81mVIqXqy3ejA1rQ3qyDgdEI
	Jjj40EeGo67JbueEAqbYJEgNPSnwB+O4eFwHXEcX0
X-Gm-Gg: AYBFou290MwGkF/RRrRv4LTCmyttwFk0SI5xiChBO8P/lMYESxEpQ5rYh/yvnHEHOW1
	WWmytUHF6GWCTFJdcTsY1KroGVsjqHojiuaB4xJQrz2BG3ARqXH0yHz9oL19HGKXvrMCnEAkuZd
	1aA3O3vhlwBMXDbasrqu/hdMywHtg4nlY+kJTk6BmYwzHxPGaTxcbBF7ZSD/rtOcVH6scK47U5c
	Jlyv6jhDtnoGcs0x4TdTOvP+TmZ1XNMf90I3/PH0wvamDix1XrZ/knkOtcKM0ksyNV+ziISnuOt
	hjLKcZW10xcPkWoKxXBuAUymEfcIND+TFial9a4G3G1AOB1fsuNAPe4C3D53uD1izFp1enozDNq
	rpnx1PKGRZq79sxbL5nSBV18RqiGJ89kMFevsl9uwZmtitZOe5ciKTRuS/DLb6eJqGiJmdJA=
X-Received: by 2002:a17:907:60d3:b0:c31:8441:35ff with SMTP id
 a640c23a62f3a-c50968355eemr1101863766b.48.1794885326369; Mon, 16 Nov 2026
 19:15:26 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261115142431.1587690a@pumpkin>
In-Reply-To: <20261115142431.1587690a@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 16 Nov 2026 19:15:11 -0800
X-Gm-Features: AclHuK-iBEn00_VVuz6qjGQnwYZ5FRJ6bny3VEMRskBOJf02b9BDmwbxXueDduo
Message-ID: <CAG2KctpP7QH=tdSB=op703rA=CtjQKAXqOen8JEHg1ygy9sgyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME and
 KALLSYMS_QUERY_BY_ADDR ioctls
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 6:24=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 13 Nov 2026 14:12:45 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> > /proc/kallsyms is the primary interface for userspace to query the kern=
el
> > symbol table. However, resolving even a handful of symbols or addresses
> > requires reading and parsing the entire text file, which is often sever=
al
> > megabytes and takes thousands of read() syscalls.
>
> Separate from this, I've wondered about separating out the /proc/kallsyms
> code from the code that actually handles the symbol table itself.
> The two parts are pretty much separate.
> IIRC it uses a static function to get the symbol type (which does most
> of the work of getting the name - which it also wants) so it isn't
> completely trivial.
>
> I'm pretty sure all (well almost all) the changes will be lower down
> the file than my changes and won't cause (hard) conflicts.
>
> I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
> in userspace for testing both, but had to cut the bottom off kallsyms.c
> to get it to compile with a sane number of definitions.
>
> David

You mean separating the core symbol code (top of file) from the procfs
interface (bottom of file) into two separate files, right? If so,
seems reasonable to me, especially since the file is approaching 1000
lines even before our changes.

And agree, even with both our patches, most functions can remain
static in their new homes.
