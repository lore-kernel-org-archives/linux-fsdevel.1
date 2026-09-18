Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0538889B;
	Fri, 18 Sep 2026 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696764; cv=none; b=r6m9WmGG7YMloxa3jOYaqyW7puDmZH4g9/VrO7VReyF4OPhd3NYKOncF07k/bFdF4jcdvK2RotkT1SNbDHSzMEITx7q8paJ3lqSyj3TpFOFaLaWdiYqRG7VRdLbCQy+dzqS21v4lGbR6toJifagBepZrhwCs6NGM8KBgU71pfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696764; c=relaxed/simple;
	bh=4xyMfp3eWJOkdRB1tNqKwqNqU32rQznFUU0AnRgm1/c=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U7AKuEmATToaludElUtbBSgQY4d7d+K2Tzvr4dCUzIoRAWAtAhbw3SFaFjU7jaoik9/eJJraCAyjsL6zGzaSl8guXFiY6X96Za58m1XiJYpJi83xx9VSvSMDB7lMsF++3eJEUQOey4jdhvKAr4WsjWLV5z3VviBez6Bj0n45QPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pLYZSBci; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pLYZSBci"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GrILUD6fya954kCY/ApjoU68FPWsIBexNxkwtfF+YY8=;
	b=pLYZSBci1O9ZpgAJTt5hdufb5v6aPP03tc9UDaq8KvGIicJFF/vpVlG23kAwCxTRE/RZIIfk6
	KwsCLLlvrUYV+cKJ6oFW5kQvK91z4qCMNLEXIvyclA8KZxjsRYjIENo3Rknf07RNeRGs9ZNUaUC
	zSfrZb1w74KviHfbUJjv2Iw=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hmFqj3GqRz1T4LL;
	Fri, 18 Sep 2026 09:47:29 +0800 (CST)
Received: from whupemo200006.china.huawei.com (unknown [7.152.185.252])
	by mail.maildlp.com (Postfix) with ESMTPS id 5207420333;
	Fri, 18 Sep 2026 09:59:13 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 whupemo200006.china.huawei.com (7.152.185.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 18 Sep 2026 09:59:12 +0800
Subject: Re: [PATCH RFC v4 23/25] fs: start all kthreads in nullfs
To: Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jann Horn
	<jannh@google.com>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
 <20260601-work-kthread-nullfs-v4-23-77ee053060e0@kernel.org>
 <15174353-3f4a-a1ca-5bd1-ea2a4c77828e@huawei.com>
 <20260917-atemtechnik-bleichen-befassen-9a57db01baf0@brauner>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <08c0cb4e-343c-b03a-020d-218d27c6c353@huawei.com>
Date: Fri, 18 Sep 2026 09:59:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260917-atemtechnik-bleichen-befassen-9a57db01baf0@brauner>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200006.china.huawei.com (7.152.185.252)

On 2026/9/17 20:07, Christian Brauner wrote:
> > The following lockdep splat can be triggered on mainline, which is built
> > with arm64's defconfig plus
> >
> > 	CONFIG_SHRINKER_DEBUG
> > 	CONFIG_PROVE_LOCKING
> > 	CONFIG_FTRACE
> >
> > .  Reverting this patch (as pointed out by AI) makes this warn disappear.
> 
> This is benign and caused by holding LOCK_MOUNT_EXACT() for longer than
> necessary. I'm adding the appended fix to vfs.fixes.

Tested-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks!

Zenghui
