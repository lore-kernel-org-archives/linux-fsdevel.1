Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995833;
	b=F9XuvuLGbNOBZLfTCj0QdBXf3gHOH9jI8LvD/3SJ75u+/NUZIJFtKTM9xXTOzAKZD3vO
	 CzMZymCfH4L3z/FzAeTx3KL/JIZYwVq8VrayCOSJjDkAu9Iz6D4zPk+pfWoBAsu0lTPrO
	 gR0giYONz7cKEBeoDpBGLrsADBMxFziH5xk4WvTGSclCWKHgNDH7i9qP5gXj2l+eH4ON+
	 9ANSNo3/7QaHlcEgDrnn5+l3QVl+st63a6eka/Ji3XB1g8P6iEuMNknsMilc0OIN7Q9bC
	 1jKthK9/BK/52OKIrcTVj16vwmUFe7Pu3SD26Lm8WxjEGPnW+dXNGG4h9jJO+WtqXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1PuD9l1hH8OOyees3FtjiIDpzh8LbMQefMah40HN15c=;
	b=rZsU5MaEcHJVhHBFsICDvKuyhLm+ALRKfaOPEklTY7TbyJs/2/mC/clC+1ly4h+qizvF
	 fM/1eKECCaNeoF8jAb8WyvetaRWqEkusqW5QPJomcPQfGCMgPLAVCHT73OT5uE3qehKeZ
	 nRfrTX5Fz5HyJp+1njyVI9rekhAhsgxioPEIv7WiLKFmpFxQG6s9MfsOPkEHch9ytyTAz
	 +5mfCyRIeyPXedLTtt5RueGAGLj3+3Ipdv0vBFUce0y1fQ0QsN3x4kZ5vmaEANUVosWV3
	 1lg5LU0L+BGmmjTwmPXGfeU89i7sd361IbNco+54N8rzQq/TXNtg5mygSVHq3XNP5JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=MhiSgMfh;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CE606A329
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 20:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 469CE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=MhiSgMfh
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so1251628a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793995830; x=1794600630; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1PuD9l1hH8OOyees3FtjiIDpzh8LbMQefMah40HN15c=;
        b=MhiSgMfhijLptj6lPoTvX15KIY6L7UlXEWtu97bHRZz2RLdkrQhDAYF3a8hG5uTkNx
         oHVwliW9gsROgYSfdBjhX+Nh6TF/9br2CYUuDgU72TOoDW4LsCGk5SWbytkkwtJGF50H
         1Z3npzHxuc2viHhG2m8aYLruxeghjRkW0mYMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995830; x=1794600630;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1PuD9l1hH8OOyees3FtjiIDpzh8LbMQefMah40HN15c=;
        b=PFA/nJnCTYsIreRF7flPLrhSZ7f+63T/j4u8HHubxKE7bYTxpOKusYDXejPN0Y4PMO
         nvkzZbtj/G1rpC76ADlRWb4JxAn6nhcsHfKLOLtM8BZ/Gb3zkzCoaHfRAcHvrwx98x4H
         49zqyjQ9DqDOT6HUzKJep0417k71Sni64CHkrdTpkd/nL5QXCACSUGpHrnmyAM0TUZnZ
         pz0/ctEBlMScmpG6YP10BoOjagiie4yEUGpt6XXq1Ij2Ft4aEILYXZIpHIC21pBuDxp7
         CtW8r0WCbpcDgiVdiva9ErkLwnB1X2PcwcRs0FusecGgu3bGp4k0mHev9ij00qShl5xJ
         IdjA==
X-Forwarded-Encrypted: i=1; AL+hErEl2PocdFDudQzY7UfCiPBx7mfNU9hH43v6opJ7JxdJGnndBNe0SGrpCc58hBCdkKVX868SEGxxW+LLoZ3b@vger.kernel.org
X-Gm-Message-State: APuU4Z8egaJlzMCS5Mv0xlqY6JqTn0SYl7m5fD6BXL+PzX/ZhmPzq6OT
	/5c/RNAmTP05/Jaq18ouSYzRMzx/2OixNzsBLDWxuB1onPIRqhXasehdkmyO3vhGCY7IrP9gFGb
	enqZfAsyaZg==
X-Gm-Gg: AYBFou1iAiqyYdUSzixGYpeAA2GYvxX9KzbDGfkwH7klpYb/luxZZit74XcG4KZbLC0
	Eat/URxP6s+rYpmLlHc6WL8FwB/GEu2YgvbeUt3rERhy9D/kTrLlqidtOhvviPwuh/J4haiHryN
	Bz3FYX93hEztnxQZwRH6BaKvzMHkzMlZHaOkgg61r21fwbUSE1hMfCOxFpxfN7y5u4H6O843O5j
	tOkmMM2ih/n9Z8ngf02REHVMb8xU4sawRRhGHNStPS5E362q02vaQh3GKknlSw5nbVEiOuBpyx+
	4n4dOabygQFYMOdbklo39HAeBaOgCCMg+u/m1KS9cfJNspG9Y8YWjycgs2Y/v8o9//RQw+PWaxf
	8JUCus3QKq4Jfyp4kAYAPVQ/hk2pT3jL7TjUd27u6aHguZ7AtscBuOrrNXplqTa6PwMOMZw7AdT
	C0XzSNiKW1PpMkW7WLY4gpNazLAd5VEDpL5y6dBTpnvTQf5rB0tPky4/qQXsgEpNUIjLJ9sDlpF
	RZn1xEgwZFWeD5TPuSr67+f5Wg6vU8bSVEr2e9pR0oHmVl+S4F37NulPIwXiJFuGVJoZBHN2wvO
	k/YYJENFYSO2EtG28o05h5oIIDihmwpVNZU56U6904jpNV20LNoIUysFSvQYsyAvXvxzGWhCH7e
	/CP0jo8YLW2I9mXVjKFi4N2Y=
X-Received: by 2002:a05:6402:3897:b0:6ac:934e:a9ca with SMTP id 4fb4d7f45d1cf-6b59747e728mr2679634a12.0.1793995830587;
        Fri, 06 Nov 2026 12:10:30 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ad17aasm1002077a12.9.2026.11.06.12.10.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 12:10:30 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so157433666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 12:10:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzacgP97JAxXnNU1WpuGdECxGaMQctpPDDeLt3KZNByar1TERQuuKx7VTFVBVEYXS9zaOF0wYAayqh9ayyE@vger.kernel.org
X-Received: by 2002:a17:907:97d1:b0:c2d:ca32:2176 with SMTP id
 a640c23a62f3a-c4d3522bf11mr295774766b.8.1793995829552; Fri, 06 Nov 2026
 12:10:29 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner> <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
In-Reply-To: <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Nov 2026 12:10:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
X-Gm-Features: AclHuK8u2vjwLORBZ85ALxektHeJKK64DjU4CTV-vhgdh1gurlxjwUzbjkbzF94
Message-ID: <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 15:35, Christian Brauner <brauner@kernel.org> wrote:
>
> A git tree with all of the patches can be found at:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.procfs.cleanup

Next comment:  3c7a6276d211 ("scsi: core: NUL-terminate what is
written to the host proc files") is nasty.

It does compares 'count' to PROC_BLOCK_SIZE, and then after that it
just allocates PAGE_SIZE and does

    page[count] = '\0';

and it all *works*, but it depends on that PROC_BLOCK_SIZE being a
random value smaller than PAGE_SIZE:

    #define PROC_BLOCK_SIZE (3*1024)

and yes, the minimum page size we support across architectures is 4k.

So this is a "it works, but it's still wrong" kind of thing. If making
changes in this area, please just fix these kinds of issues. Use the
*same* constant for size comparisons rather than two different ones.

             Linus
