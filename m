Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB84414430;
	Tue, 13 Oct 2026 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855406; cv=none; b=b7dGs9cCWLgdUIkpQl2rJ57IXy5qrxyDqnkGNBunF32JduqTALbPDADZTahNHbra62sY55s736LQQIKnw2hzKEYLYkzWnMirNXU8QwasNo6cesK/qGm0WxKY4DbmWUcLlUM1UHNip3173cjNZDhy1MmMBs7prN/h0Bs1IYsR5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855406; c=relaxed/simple;
	bh=matAveinNTUlcxKBuMzQT+D9b5MqR2bcdVuqw/hHpTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATwkgarXNPM/uMTQZisLQ9QbI1+ZA9dvK0SEW8PZxbZW51br6guYtBs6ae6RpGRT78sOdR5px9SYMwlJ9ou1drwUEAKPCMsjATy3Th3O7mbbFot5L4p29GvFVvSTR2xLuG1vj7CpjKIqW3auhiV7NSE02HuBYrLw6tjBwcRO2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=DXCEsHxa reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="DXCEsHxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=matAveinN
	TUlcxKBuMzQT+D9b5MqR2bcdVuqw/hHpTU=; b=DXCEsHxajkGEiWJ6fQV5OvrsM
	QsKowj9vehBsA3R6H66Oos5LVQ1OZy7Bx5cIveImgJOQ7AmRuMwzridp2T8uD3K/
	lKA2HJ9IAcO2aogwuoKGGs5PHC4AYtq8kAKbetfhTQmX7ZBQOOzyBliQuTJrxmpj
	peeco+iTdBiiK6JjiE=
Received: from [10.101.142.107] (unknown [218.19.14.194])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPSA id BrQMCkDW_wUci81qVxKKAA--.31905S3;
	Tue, 13 Oct 2026 09:36:30 +0800 (CST)
Message-ID: <94ee706b-f7b7-4d7c-b094-a6fc9b9174b4@stu.xidian.edu.cn>
Date: Tue, 13 Oct 2026 09:36:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
 signaling
To: Oleg Nesterov <oleg@redhat.com>
Cc: w15303746062@163.com, David Laight <david.laight.linux@gmail.com>,
 jlayton@kernel.org, chuck.lever@oracle.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, alex.aring@gmail.com, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
 <20260523135210.590928-1-w15303746062@163.com> <asI5Fn87_SoEd4G5@redhat.com>
 <asuxzwl4iWjjEjRD@redhat.com>
 <437297ff-1bb4-49a7-a979-abccdd1814f8@stu.xidian.edu.cn>
 <asz_NnX9_KaJdaf_@redhat.com>
 <dbf95fb6-1685-463c-a533-79024d7a0a18@stu.xidian.edu.cn>
 <as0K5CT8IIaCWsfR@redhat.com> <as0Z302oRQpI7rgX@redhat.com>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <as0Z302oRQpI7rgX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BrQMCkDW_wUci81qVxKKAA--.31905S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYE7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVWkMxAIw28IcxkI7V
	AKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1_HUDUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUFEWrM+jxatQABsd

Hi Oleg,

In the scenario you described, the tasklist_lock reader holding
dev->event_lock is in process context. That explains why the
interrupt-reader handling does not rule out the possible deadlock.


> perhaps it is time to add pid->tasks_lock or abuse pid->lock we already
> have (we would need to make it irq-safe) but this doesn't look nice...

A fix also needs to preserve the synchronization required for process
group traversal.

Mingyu

