Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062678;
	b=EsLI2BsKvhvPG3uOj4IPUo27n566/+i1UGI+faJ1bT09vbwTTZ1CK4Q8GRxzBGuYko/u
	 r3jeZYzx4Rc5d5/BtKvswglZS5RBUbSIbBh8bZh12JPVfMU3RL+isSpRd7JmcVw9YbVQS
	 bP4GLz4fF9ui0s5J0IU0PcUJbdYOD6kOvX7lSkFROAA6V6n7FWgaomjLmW221IpIgvpN2
	 0AlX9prDtByVL9bdnnjc7ZDUQ/ZkR33Iqh6OKjcaTM6wRBVMKkyVFgewBwrPbFZsb43DG
	 dwUSjuFWgB9594VPBAGiILqpBJa/c9hnLvPIS0d1HH8daJBpYrLK9Pp2wt/xOJEDK3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PixEuIlz0J326DRKLzRZTRCRckMWEmO8LrFWZwm2Ojs=;
	b=XaZFCH0FWVKquI/nm9zKpu6rfVuBKId+i1XKkEmfo43jx/68EkW2rdv8BRmOSxFC1eKO
	 QmtyX/WILR44B6KWHtbrfYbHjEmwIOnzUd1KhuzLtlDbPj6WR6LzMPidz26eE6Mj0LEnT
	 shBsQPK7wGXM9wf79AgaNurGnIu5poVb2I5raxeRseuCCvSDn19GYlB0JYjUKLKmiuZxU
	 mHI3vTD7Q5nNqQHVXFj0n9Bljm5IhZepAb/WeZ8cm6m0cEuu1pG+BDQZmiZxMmZzYWvvc
	 NvFQjFGM+uXCgKBX/IjMakTXrB3gt30UK7sDKy0kGJnkKRfTqxc56XRf+S3mys4peEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b+JD2N5+;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC6606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 00:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45BC6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b+JD2N5+
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso5344458a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793062677; x=1793667477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PixEuIlz0J326DRKLzRZTRCRckMWEmO8LrFWZwm2Ojs=;
        b=b+JD2N5+rYVooj8Ej/IvUFc1dN/wiaOUFruTy9kN63mrAIfXTfvhO71wV9X5nkq2PD
         wRjFzdbP1cL2mMyjlvzi7fQlP0tbFg82kYFbI00W6Q8xvpbRXz1boe0eAKHHfpEs07Hw
         TLSFRbETHdW7qxLZHEaTl0E6zFQed0As0r6q/xXozeJkVNdjH5M5ADoRsfD8xFB6jH3w
         zafLdnnkjqoYX9fTPaC6r2U1J1AW+bS4Fbt3cCsbY7EeivWpGTkNjNFqy90Gmec7L7+K
         nakS23YW4EcihM5dz8PR4wy3mHfkMFPrqKhRq7o7C+2k0BLyT64M2cju3d09MUD2c7yE
         6mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793062677; x=1793667477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PixEuIlz0J326DRKLzRZTRCRckMWEmO8LrFWZwm2Ojs=;
        b=cLneU6NebXrCXutMLxZhXN7bHEaj1nJi3V62h2hhZ7D9T84yO43MzKC+aO7wLmgtrj
         VJlS01iOOcbJYB059StewCzujBbYAvXj5KbmStU68oG4P/GeFBzEXCgQrivl+MWjHgMi
         T/poH0rvqTU9FIhyz5QIAKASqSDGoUgBkCQNr1U9tgYM7sJEGwUOH+k7eetr0vt6fLGC
         3ETkTQMQwa0M0+xFST6WfcRyIJy5z5C/iBIpjHz/0SE+EZbsv9g61OmrK+GdszkHxOjD
         dkNhylD2IaxFBnHaK/O5ld4CHCBZS1LgN63vKYHe+LDXlsfcbSuCeCmaJn13+PZ9Xlb1
         u42w==
X-Forwarded-Encrypted: i=1; AKwUvByqZZpDi6kSsz0TqOaCvdVhZ957Z9cB/JlIY6dTkrTAhrvcfOSovv5tbZqHvLu+7rnqx4WlP9F/jgsIbfDa@vger.kernel.org
X-Gm-Message-State: AFq9FYJfFp9naqe96DXDOyIeWDCBGuE+23YVbelqV/8rxb7/G/QSf0ne
	dEWAT9OpOpaM/afyXp5/nXQDpMz0X43uWm5XLg7sgqhmTYW5CEryof5i
X-Gm-Gg: AYBFou0oc/bBnvGFD4sua1qvvRy368adihpBydwUZVGklYDHwvpvpXYVDEgIKCNqVTI
	dcXfEXAvtvEzQuLGurk+mY2Rcq4xjaBelSoSPlontp8mYp6F0iH6mOA3xEXmY5LDrWCUljhXMTY
	zAJZ5fyXzfohKvOj2fY419DYQg0/c1jvX9ZMQAsaLE5AanBtH9Rn8tbt0GL87dmpvy3kwRb3Nwe
	gzf9sZOSrhvpmW8CWe4UieLUbOS2kb7U3hoRF+LDcdYn7kNhTnS6KV9dkSBnyzclU4Oh20LUyF2
	qy9w7TlcHvurLWXXmAmeLcA43qMgBYOHP5BJK8g4JSI9CrgfOBuuIf90H9KKrhFjYUBZ9MdJMu1
	puhg072IzUT8OwhiKxhlFy6wZYUaukMSjpEWgkuYJfNaZPr8RtWi6xId6EO1u6lE1cqs2rctnYx
	i5hqzhowEKa/6ZeX+4jBrQJBcOyUuc4JWiIHha1AQHAjn/CSJ0ZfePiDa1uCOFREQW+O+SYZSiT
	C3BckhmgwGJQhd2Oe1IMU3iY4pyZ23E0dSy9q0+0M090w/Dra6R+KCMGJ4iECVQ3HDB6vUylI5t
	Sm1o5a4hSOpeN0Mqvt9rBgSJpdD9s3oSkM+3mbG+Xks9tgd4hE/xoYHVa+HtEPeXwAYb0Q3Sp4D
	gHF9WXxyIH2CxRSxDYcAtMvmCq8ccvYV+OpNFMM42Tt9Yq967b2i6iVMGoLYBIDA2w2LM9Z1Fc6
	Gt/Z/Bs8vRE1Pw99U=
X-Received: by 2002:a17:906:f593:b0:c31:8984:7fad with SMTP id a640c23a62f3a-c46bddf6451mr917653766b.15.1793062676398;
        Mon, 26 Oct 2026 17:57:56 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595df8fsm4283637a12.11.2026.10.26.17.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 17:57:56 -0700 (PDT)
Message-ID: <083c2bb0-85b6-480e-afcb-bd2f386f2ddd@gmail.com>
Date: Tue, 27 Oct 2026 01:57:54 +0100
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
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs
 stores
To: Ian Kent <raven@themaw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 driver-core@lists.linux.dev, autofs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
 <cover.1792577179.git.krystianmkaniewski@gmail.com>
 <dc65c28e408d6b64d4b13b7ad30e5fe70ddaa441.camel@themaw.net>
 <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <4f56c93a9fc5fee152364974773df0a319c84af9.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ian,

On Tue, 2026-10-27 at 07:11 +0800, Ian Kent wrote:
> Commit 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev
> in resume_store") looks like it's been around for a while so I
> assume the reproducer should work on 7.2.12?

Yes. That commit entered v6.5-rc1, so 7.2.12 contains the relevant
code.

I used the unmodified C reproducer linked from the syzbot report:

https://syzkaller.appspot.com/text?tag=ReproC&x=11c0f4c9580000

I also used the configuration provided with the report:

https://syzkaller.appspot.com/text?tag=KernelConfig&x=7d012d9c67977ee4

> What should I expect, a hang, it doesn't.

A permanent hang is not expected. The result to look for is this
lockdep warning in dmesg:

        WARNING: possible circular locking dependency detected
        ...
        &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex

The reproducer records the first dependency by splicing into the
cgroup v1 devices.deny file. It records the opposite dependencies
through a normal write to /sys/power/resume. These operations use
different lock instances, so the exact reproducer reports a possible
cycle rather than deadlocking.

The write waits for an autofs daemon that never replies, but the C
wrapper kills the blocked child after five seconds and starts another
iteration. In my test the warning appeared in the first iteration.

The test needs lockdep and CONFIG_PROVE_LOCKING, the cgroup v1 devices
controller, autofs, and working hibernation support. It must also run
as root. Without lockdep, the program can appear to do nothing useful.

> Also it looks to me like the reproducer is trying exploit an
> invalid request similar to what I described earlier

Whether the string identifies a usable resume device is separate from
the autofs request. resume_store() first passes it to lookup_bdev(),
which performs a pathname lookup before the numeric fallback.

The reproducer changes its current directory to the root of a detached
indirect autofs mount. It then opens /sys/power/resume using an
absolute path and writes the relative name
"0x0000000004000921".

The resulting lookup is therefore:

        <autofs root>/0x0000000004000921

For autofs, this is an ordinary lookup of a new immediate child of the
indirect mount root, so it is a normal mount trigger. There is no
autofs mount under /sys/power.

In parallel, I am preparing a revised patch following Tejun's
suggestion. It disables splice for writable opens of
/sys/power/resume and gives its of->mutex a separate lockdep class.

If you send your autofs change, I can run the same reproducer against
it and check both the request and the lockdep warning.

Thanks,
Krystian
