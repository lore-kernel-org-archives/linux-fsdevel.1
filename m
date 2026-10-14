Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB33F65F7;
	Wed, 14 Oct 2026 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980237; cv=none; b=dHUT6kXdzUZFFiIDxT/qSHoDDJux/+v8OKloqHdtiCy8H7pT2QSC1lrIXnnTWZ+kZe/DxcJOPewONnN4O3dG2G14TlK5308A3k1lEnRx4yawjD3BoWHyha4YlML7Q2CB3aZoa6zhdl6dat0EJ5FIvFPbkXX3zI+X81FG1sPHmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980237; c=relaxed/simple;
	bh=veCUfRKCqpNHQBjhbMLIp6hrKKSGqofZI97x/BDtZm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUZRhC8GrRnJis5dlcuYF9piMBqXVG1+YzyLAWtB6jiLKn0AlTl+sOb6Cgo+GWDFgHxkpWU2ZN0gSg/l+2tIsz74gT4DN0TL56CixzVRj7/8GWiUa6nz5fl/7S1WzKr/bwSQyUjPKhf+lLunL9Zn+K3qrJqa636rO2QVd5Bx2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=RKcgsoed reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="RKcgsoed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=veCUfRKCq
	pNHQBjhbMLIp6hrKKSGqofZI97x/BDtZm0=; b=RKcgsoed8uj3gI1RFotiWe3gR
	YNzTZu0b3AvWlRsTauFRXMItcMi2t6g+yWJc1n96M9MkUkm73C/UTD3wzDAOvxMe
	qSqOKMUTMtZJL9nRYgHw/ILJLN544GztcA2CITCU7H6g4Czce4Y5xgityBrveWhz
	UvMP/D+7gNlFDMkBYs=
Received: from [10.101.142.107] (unknown [218.19.14.194])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPSA id BbQMCkDW2v28cs9qJwuYAA--.43603S3;
	Wed, 14 Oct 2026 20:17:01 +0800 (CST)
Message-ID: <fd2dc28e-6a55-4b9c-ab61-913b57b85335@stu.xidian.edu.cn>
Date: Wed, 14 Oct 2026 20:16:59 +0800
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
 <94ee706b-f7b7-4d7c-b094-a6fc9b9174b4@stu.xidian.edu.cn>
 <as9vE0quEcL3_5Ke@redhat.com>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <as9vE0quEcL3_5Ke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BbQMCkDW2v28cs9qJwuYAA--.43603S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOj7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
	6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW5JwCF04k20x
	vY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
	0xZFpf9x07j01v3UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUGEWrOSVHGFQABs9

Hi Oleg,

Understood. The immediate priority is a fix suitable for stable, with
the workqueue approach left for later consideration.

Thanks for working on this.

Mingyu

