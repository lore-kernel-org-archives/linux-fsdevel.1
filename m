Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F33976B4
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776553719; cv=none; b=DanDHt60LAyoPHZPahssA+Ule2DHzwXfSvvWb8YJCPamsAg4Ecvg93s+hk/S6cQzbptsMLYeFLJDcaaJQ0skwirf1BtIFQfGHaCQRqDyNqzXn2DaTBS88VG8oi95MZhFGpLdY4FouzE48saXjcFCZ71PV/jtI7ksL4gwcpSBaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776553719; c=relaxed/simple;
	bh=Xar4WmIgCE2sEueWRogWtI/LcIsN6hYef9Fkw6uWnIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt1YMR6rbemkDVQCn2p+//4kpUAJ+1aKzFUPXeaXOJi4iGoCFfTH2Kg20a5hM4eD3nG6gpOowWiN46y26GI9xt7iS6okAD/sUhTHP4Vka0uucLCQiMv0A3v0H6iqksu7hg6IyrJdUD1w6Yt/hA4Li+sg8/TUvVVqRt57Ejoub24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc8x+fkL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc8x+fkL"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79885f4a8ffso18500147b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776553716; x=1777158516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QDLBwLu2Osjs067OAPxTWdOsEiACtCr2ZJS7OWNSDmU=;
        b=Nc8x+fkL9qtiX9YPOgvJ7Z+Bb36HJhLdTNZe7s5v5bpawRLtP+8JQ9G0CluZ1eYzCz
         G3k4VD5z3g97Ceiz9imYe3gJ2XVrsGRvbHL4p8M0RNRgiRph6DM5Cokg5qkmBDNcLCBc
         06IAIDvXrIT4J3CNjIUXIVrDnLJ78Wm83PSwwjf4KOVGG4VPSauquGiW5gFX1u+vIe+4
         Lj3TXNgT/ABfbMQi4/dRYv+PAv8DLZG8yLdwax6vHXfsmURhva2MeMqMbwfTh1a9yK/+
         6teqOhn7fdqUz34CGqsDqPpQXMBzGZWwCOXTo/uzrYy2CeXQnd0S2reo3YNZ1HcBZKN8
         2WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776553716; x=1777158516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDLBwLu2Osjs067OAPxTWdOsEiACtCr2ZJS7OWNSDmU=;
        b=SobDPVc+p1hb/GA3B3llAWeXENA5DOKwM9fj6qk+KGxa1o6ZpzjHzcAl5VUv9AGTYl
         ejKist8u3tNVTXxPE3sLMzIG+7t3SRpySbxBmwSQIHCBlQhcYFQQxGCe9Aw3zmqWjj+S
         AuGm33KJ/9YjGHBbGcZDcDckN/ldGQPPbRWNInG+Mqey2wDteliHVoHTrGjjyRTOqmLQ
         KNfgq9vBv2rJHT+EKkdMnVz0TyXI/67LhU/Zx40QjPWarbhqJOHnPb7KcRfK3kXeJfZ8
         dP2IIzZKK35D4yMDDt7ItbEuEZau22/ywEQQlGTkaqCDm91pAlHGTjVabeQp90yjKYPq
         CUlg==
X-Forwarded-Encrypted: i=1; AFNElJ/3yt2CvQqDs5hvPlAysPQFJ7ZUuIxj7okTVzXF50oWWZ9nQJM+fpx4owmUoh6Qqaqiz21haIRK30Uz5gT4@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpR82zwbvWKoV+R4C/CyNHRpzU7Rpw8kWu+i7aU0Jrwq8dEvd
	VvpQmg3N4LwzXggkYJPvnnK1yTeOk+NkacR1VFnS35ORUu8aj/KM4FES
X-Gm-Gg: AeBDietik4iC+0W5GVL1AxkUtrSGnRFS6Rzn+6RykmuqFsm577Z9m4zJ5+G+wGSGlxh
	UBcw8omuRqhWnveOYfHmWCuly5ZRPbsO0GTqIKROjjabWM7V/PXY3eUVoo7pp+J4n/qCEypbOKn
	rJCkdAyF2k/csOdpnyWJIJUAHli7rGJHOM9PIelrIJATUkB0wlnhp/djSYZ8iGgy4LXOKw6HzJt
	mloWFX6J2y3s/p6LwPucbIVbYh+543lajf0qTq0tLbUiluWPKUR9UCKOj0xqLS8/Gnvh7p6S04b
	Y6gBDS/3VcIdPp1iK+a1diWbW28iBqC4EITJikm2NH0+AEi23EfuDXonJKZZbsDa+7olNPNptpY
	2YkiHB5SQHZPch9jIYslD9tGM9Nwn3HTr7VMiGOWfdlfXvoK1+SPJphnsGIVQQnWvwdLgw7aY+p
	17UrrUbO7mCQ/fS6qv4TTVGfxdppnTk3SBAQ398V6LUWQnl1G6oSGCZYYgn/TOTZzUlYxvyBeZJ
	guqYno5ezxszg==
X-Received: by 2002:a05:690c:399:b0:79c:c51c:7f4a with SMTP id 00721157ae682-7b9ed002905mr87916127b3.46.1776553716465;
        Sat, 18 Apr 2026 16:08:36 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:3b24:58f5:5e89:7648])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm24805917b3.27.2026.04.18.16.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 16:08:36 -0700 (PDT)
Date: Sat, 18 Apr 2026 19:08:34 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?B?546L5b+X?= <23009200614@stu.xidian.edu.cn>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, paul@paul-moore.com
Subject: Re: [BUG] landlock: warning in collect_domain_accesses via renameat2
 path rename
Message-ID: <aeQO8plVsM4dg9jL@suesslenovo>
References: <25536ce2.4391.19d9b3484ff.Coremail.23009200614@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25536ce2.4391.19d9b3484ff.Coremail.23009200614@stu.xidian.edu.cn>

On Fri, Apr 17, 2026 at 07:30:03PM +0800, 王志 wrote:
> Dear Maintainers,
> 
> When using our customized Syzkaller to fuzz the latest Linux kernel, we discovered a crash related to Landlock during a path rename operation.
> 
> HEAD commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449

This is the initial 6.18 release, without the stable backported fixes.

> git tree: upstream
> 
> Reproducer and logs:
> Output: https://github.com/manual0/crash/blob/main/cebd27007e806e16cf15cb1e0214c24054e8998e/report1
> Kernel config: https://github.com/manual0/crash/blob/main/6.18-syzbot.config
> C reproducer: https://github.com/manual0/crash/blob/main/cebd27007e806e16cf15cb1e0214c24054e8998e/repro.c
> 
> ----------------------------------------
> 
> Analysis:
> 
> The crash is triggered through the following path:
> 
> renameat2
>   → security_path_rename
>   → current_check_refer_path
>   → collect_domain_accesses
> 
> This indicates that a path rename operation triggers Landlock's path access control checks. The crash occurs inside collect_domain_accesses(), which is responsible for collecting the current process's domain access rights.
> 
> The bug is caused by collect_domain_accesses() traversing inconsistent or invalid Landlock ruleset data during rename path permission checks, leading to unsafe memory access.
> ----------------------------------------
> 
> If you fix this issue, please add the following tag to the commit:
> 
> Reported-by: Zhi Wang <wangzhi@stu.xidian.edu.cn>
>
This was fixed in 6.18.2 with
cadb28f8b3fd6908e3051e86158c65c3a8e1c907 (landlock: Fix handling of
disconnected directories) [1]

So this has been fixed upstream and backported already.

Please target fuzzing against a supported tag.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=cadb28f8b3fd6908e3051e86158c65c3a8e1c907

Justin
> Thanks,
> Zhi Wang
