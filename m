Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643254;
	b=JLzoOvIJTocvTGqtp9uDg8X7l63YyVh8yakwGycrYk4wtNOJK2Byyr9Eu+Zfc3jvC0kz
	 ZeE2+51HSyzGyH4LhQiFLofQT7iOC3sYZRqDGw3j5YtJUyNciD15c6xh6d9ZkeafljvDc
	 mFV7pQPfrmRaEVni5LlEWUEaM3SmgtsfzysYJ0BLTABfR+Th11MrvDZMmjbBeuOQHEa5e
	 Lx+O93S4Hrv034GH34LcksA0ZkqndHFL9w/yHpYCBbqyyO/PlUhuIaDRs7P8P9J7JdVUV
	 Ko7+wwsj9JjzumJ980qW2wCI9XtK5LmPcXStyimJ5mmTWui6NKQzzXESfGACpgODvLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qYtfSV7pXPeTfIc4mFEoIenAEwjJso8HErV9eJ0iS/Q=;
	b=jWiOKHYtUFmLkGXGMzFlHT/J3q7Pbk0Aqd1m3y4dnIu9LqP/Ujm0IQQtL0kpfLM5y7OO
	 qsxngjk6HmFsQdwZIYTVZf88eDJbAD3gof05ikQd2Ctu6o8ei6GD0Zy68QkAyVDuCdU6c
	 sPHUMLYT1hrmfmaQdo53mUzzbApt3QoomgkkgRKdWEftnR4bEzl38DELzC77vknOsn4wO
	 bByl8d1Ja9Ok1I6H4BUegfzylvjzE1erQbQNpacjFPdoxCr0K9cUyusngpU8KRG20iWmt
	 i2mpZgK6aR2gCvwGzljFCG6NgRsSpEaPJXEfaGO27d+83dHLOC3HoDsaL+Forvt7H8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=QhSgR6jf;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E4606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 21:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 560E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=QhSgR6jf
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-386cf1041cdso2289766eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795643252; x=1796248052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYtfSV7pXPeTfIc4mFEoIenAEwjJso8HErV9eJ0iS/Q=;
        b=QhSgR6jfKHc4KQuRrW28/UnwFauHpcwusBDSzItvH11mJAYX4ilqK4kQPo+RGc9P+b
         l7TQW9X/6+DH/ct2BvVRqHhNI2pprR63/itI1TTWOhIIy6TotVfu8p2lhIbMj3sBZKj7
         pwvgBfaST27s7N1+aFKIOI2ichwtiGqkAFOjaBMOG+qACgbMDTvc2zj0k+RQ1+Sc7jyj
         ZTSgpq7HTWLZqO80lFZq1uobzVzGYUScIwuS8KIqxy4lLTCMHsns02qz2o+c0LElwZF9
         vmuiXwHNSWK9y74b18KXGcCZOFqNq/Zuil/IuBnMrQhP5SM2HJ6Cw9lBKA3YEiA3v2do
         zfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795643252; x=1796248052;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYtfSV7pXPeTfIc4mFEoIenAEwjJso8HErV9eJ0iS/Q=;
        b=vlGDcK5xE1jz3l6slvfOydhNW/64nkUffKj1bmgtrSZxKolwX54pwgNellG1eyEgM4
         Y/hXOvP8a7wZGNlIs5bIWkDzoiE8JByE/9LqQKVGqYRdLI8ffuZuJ3QKFxwhLDTXo5hf
         z/NcmuAhR7eWkAcZKZ/s4Ty2AmviFfdZ6IRpc1AOr80uy0jlhshODsNqU9OGObe6CH/D
         2jbC7IYCtGixocMNFcfo929dCN/1XgsBcW1kV/8as8GOnsV7jBTGYYJiDNMbPZPtBzQX
         4tcJ+8wMn9M29kxcdw7GKuUoN6g9oNmyMLL9vicHthLn7zkazdqQus8YyIL7Wzmq879z
         Uq0w==
X-Forwarded-Encrypted: i=1; AL+hErFn1ijAHVy+wujToxaN3r6fkhi+bWCHOESOBG4bZAgJdulI0R+3PLUgR1vp/ny4UPsBv4KRciYomQeDczbI@vger.kernel.org
X-Gm-Message-State: APuU4Z/vqxTapegzayfhfaopug0WajRwHeYG+MCXJOMU76pel1cN/v3c
	SdiQBMs6mCPGKVIrEh1mxdxxlzMV+8JFZBNPzAebzbMfq7Z1WHS+Lb2ZxVrD1UXt4XM=
X-Gm-Gg: AZFdTZeG7OhsOd212k6bJtu6qMHTpat1hcBSp0ClX4V2StXK9ExBzQ/nraz86LefFWM
	6pK6jDFYpbKDkvW5hxwx3xHiubceadFWG9NyEFxknXOJddaaZa4B9b/m+0wgO2Nwsp+IMHZYwyB
	aKc9Mojz3ejsr8voRZeUh6lw9D3Ofc0PA0Z2IyGmcvIqGNQOr+rqIH466Cf4nI8v3p7/TMAZmu9
	5tR9L81mCv2sF8DWzi0s7Us0VXvoJVKC9NnSuYfHoh4b4IPllROdI4a6PVgkTH9NLoySN81hBFx
	ELELTc2UwSzlzuMq84g9lWZ+x8yBO4V/LpNEiIvaskV2s/NdRP9OVpIg6KiSYe/FUjbr9P1orYk
	4wHp7uorcjM4wee6kbkPtmMZ2aSmm9uU1TgSInZ/Qc6QHhkCLl0Q4TvCJEpB/V0pQ26rb2bROSd
	AoUWEgYfGR7GbZttVXT+9y7Jxr2SX7eAYdK/Hm3/1UEG9wvTbEYJIzO2GSDohhiV7Q4erlAgwWu
	syX5NfPFUAPXjFxf7w6+C+DnZUhHGUlVlw8XBIjyQxorbyWfYnulQTtZa6olVa6OCbSyOGBmb72
	/RDqYFcJUThz0kFd3sZCRUZHcDSMCh8Cjo49YMcmXsdL0LnAabORiBHCEODNiiQCebdRbBINk3h
	cloZ9vdrmYRzQHGNBQzeqVYPBeN+XgB3eVBHrNMJr3Efmg7TT
X-Received: by 2002:a05:7300:c001:20b0:386:d2a2:135b with SMTP id 5a478bee46e88-386d2a213e1mr2605327eec.39.1795643252198;
        Wed, 25 Nov 2026 13:47:32 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm100644292eec.3.2026.11.25.13.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 13:47:31 -0800 (PST)
Message-ID: <86fea5ad-43d5-46d6-b2e5-f93b8a6afb8f@kernel.dk>
Date: Wed, 25 Nov 2026 14:47:30 -0700
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
Subject: Re: [PATCH] io_uring/openclose: allow an empty path with O_EMPTYPATH
To: Jori Koolstra <jkoolstra@xs4all.nl>, Hengyu Liang <hengyul@cs.unc.edu>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261125180817.3682397-1-hengyul@cs.unc.edu>
 <170898867.2781789.1795642036410@kpc.webmail.kpnmail.nl>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <170898867.2781789.1795642036410@kpc.webmail.kpnmail.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 2:27 PM, Jori Koolstra wrote:
> 
>> Op 25-11-2026 19:08 CET schreef Hengyu Liang <hengyul@cs.unc.edu>:
>>
>>  
>> Commit 31cf44efa6df ("vfs: add O_EMPTYPATH to openat(2)/openat2(2)")
>> made build_open_flags() accept O_EMPTYPATH and turn it into
>> LOOKUP_EMPTY, so that openat(fd, "", O_EMPTYPATH) reopens the file
>> behind fd.
>>
>> However, io_uring also uses build_open_flags(), but __io_openat_prep()
>> still copies the name with delayed_getname(), which rejects an empty
>> name with -ENOENT. As of now, IORING_OP_OPENAT and IORING_OP_OPENAT2
>> accept O_EMPTYPATH, but fail on the empty path this flag is meant for.
>>
> 
> I think you should leave the reproducer from the commit message.
> 
>> The issue can be reproduced with this program:
>>
>>     #define _GNU_SOURCE
>>     #include <fcntl.h>
>>     #include <liburing.h>
>>     #include <stdio.h>
>>
>>     #ifndef O_EMPTYPATH
>>     #define O_EMPTYPATH (1 << 26)
>>     #endif
>>
>>     int main(void)
>>     {
>>             struct io_uring ring;
>>             struct io_uring_sqe *sqe;
>>             struct io_uring_cqe *cqe;
>>             int fd = open("/etc/passwd", O_PATH);
>>
>>             printf("openat: %d\n", openat(fd, "", O_RDONLY | O_EMPTYPATH));
>>
>>             io_uring_queue_init(1, &ring, 0);
>>             sqe = io_uring_get_sqe(&ring);
>>             io_uring_prep_openat(sqe, fd, "", O_RDONLY | O_EMPTYPATH, 0);
>>             io_uring_submit_and_wait(&ring, 1);
>>             io_uring_peek_cqe(&ring, &cqe);
>>             printf("IORING_OP_OPENAT: %d\n", cqe->res);
>>             return 0;
>>     }
>>
>> Before that commit (v7.1), both calls fail: it prints "openat: -1" and
>> "IORING_OP_OPENAT: -2". After that commit (v7.2), the result is:
>>
>>     openat: 4
>>     IORING_OP_OPENAT: -2
>>
>> This patch will copy the name with delayed_getname_uflags() and
>> AT_EMPTY_PATH when O_EMPTYPATH is set, as io_uring's statx already does
>> for AT_EMPTY_PATH.
> 
> It ain't a sin, but try to avoid "this patch" references.
> 
>>
>> Fixes: 31cf44efa6df ("vfs: add O_EMPTYPATH to openat(2)/openat2(2)")
>> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
>> ---
>> I found this while comparing the behavior of different kernel versions.
>> I used an LLM to analyze the problem and to draft the patch and this
>> message, and I analyzed the result myself.
>>
>> Tested on io_uring-7.4 (0659e44ce739) with KASAN and lockdep. A test
>> that runs 24 cases through IORING_OP_OPENAT/OPENAT2 and through
>> openat(2)/openat2(2) now gets the same result from both (32 of 42
>> results differed before). The cases include O_PATH and regular fds,
>> AT_FDCWD, forced async opens, RESOLVE_CACHED, a direct descriptor slot,
>> a bad pointer and an unprivileged reopen of a 0600 file (EACCES). The
>> liburing open tests and the openat2 selftests pass on both kernels.
>>
>>  io_uring/openclose.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
>> index 24cf3ce2e2bc..29fe31f16a2b 100644
>> --- a/io_uring/openclose.c
>> +++ b/io_uring/openclose.c
>> @@ -54,6 +54,7 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
>>  {
>>  	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
>>  	const char __user *fname;
>> +	int uflags = 0;
>>  	int ret;
>>  
>>  	if (unlikely(sqe->buf_index))
>> @@ -67,7 +68,9 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
>>  
>>  	open->dfd = READ_ONCE(sqe->fd);
>>  	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
>> -	ret = delayed_getname(&open->filename, fname);
>> +	if (open->how.flags & O_EMPTYPATH)
>> +		uflags = AT_EMPTY_PATH;
>> +	ret = delayed_getname_uflags(&open->filename, fname, uflags);
>>  	if (unlikely(ret))
>>  		return ret;
>>  	req->flags |= REQ_F_NEED_CLEANUP;
>>
>> base-commit: 0659e44ce739ecd856164c75a5325b7959a2921d
>> -- 
>> 2.53.0
> 
> Reviewed-by: Jori Koolstra (CIQ) <jkoolstra@xs4all.nl>
> 
> @Jens - You've pulled this already, I don't know if io_uring appreciates reviews
> after pull. Let me know if not.

Always appreciate that, the link is in the commit too so it'll be
discoverable after the fact as well.

-- 
Jens Axboe
