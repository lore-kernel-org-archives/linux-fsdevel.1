Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017E3F9F46;
	Tue, 31 Mar 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969920; cv=none; b=FNwbotKrTnG7m1qEycI/MClaWQiflayIbxI9vj6QmH6kIxUcNfQU0Z0G8i/u4wqVbBEY70c3kPBwySYaR/5tTEDR9lQjLf277zC0XXcmy6MslEJNfVYIMbg9/Pc3LGmIgJgSy2Jg6sSPtG4Kgz2uwATQChGiIZUfRE8EY2DnpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969920; c=relaxed/simple;
	bh=IsPIkDdoyxK/+wJSeEqBy4WPXr5xHukzBDsnvj7+aNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HV7pRaA7knbUWJYvqMbuBO51HOLEZiGlBARgoQOJBnTu9EWfawjDCoYuwBXYvVHKnQVHjXJje7/dA1A1oOlkwAj29EViar8f+45N3RF4IGHNjySSPfNcMlxw/Hi49AbvZ0+RDjHTLdUctz6eDi7CDZnT/QaKfjh6V5T73R2uLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vPuKvNCd; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vPuKvNCd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774969913; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i+nrivhWD5NTb/vZqEvDP+XAAng2CVzM0c4MjNWMQis=;
	b=vPuKvNCdw63YUpeGaZ80L33WzYPimoGqpYycAPSuXxcisMoyzou4LdqxrSM3KAFtHWr9ZFR6M4wF0hu4d6LkmfzglQ8mgKeknD1T+AST9MHlRfV0IWjUX1NAhE9I0SjoSHPN+SBIJkWn2a0/Xdv/AGVUeNfORNws/G3Mck7GIpQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X04lGDE_1774969910;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X04lGDE_1774969910 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 23:11:51 +0800
Message-ID: <eb46cf29-2ac5-4586-a76d-c6a9d7b6619f@linux.alibaba.com>
Date: Tue, 31 Mar 2026 23:11:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
 Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>,
 Jay Shin <jaeshin@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>,
 Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>,
 Colin Walters <walters@verbum.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
 <4184b060-2923-4722-9899-c85238b8e3eb@linux.alibaba.com>
 <6qfk57jj64a2t2mwjsldtvne6ooctpnfhpwisexctlntqa5mpq@s2lumil5gddf>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6qfk57jj64a2t2mwjsldtvne6ooctpnfhpwisexctlntqa5mpq@s2lumil5gddf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026/3/31 22:59, Mateusz Guzik wrote:
> On Tue, Mar 31, 2026 at 05:54:01PM +0800, Gao Xiang wrote:
>> JFYI, another issue we once observed on user workloads is that
>>
>> `d_lockref.count` can exceed `int` on very very large
>> directories in reality (also combined with cached
>> negative dentries).
>>
>> It can be a real overflow, this commit can help but it
>> doesn't strictly resolve this, anyway.
> 
> 
> Another way to contribute to the problem is to mass open the same file,
> which results in one ref per fd.
> 
> Or to put it differently, sooner or later the dentry refcount will have
> to switch to 64 bits on 64 bit systems.

Yes, but my own basic question on this is that do we
really need 64-bit refcount for each dentry?

  - do we need to cache so many child dentries at the
    same time? some real use case?

  - do we need to cache so many negative dentries for
    a single directory?

  - do we need to really care mass open the same file?

or just find a way to error out blindly when the
refcount is nearly overflowed? together with this
retain_dentry() change to make cached dentries
in the low watermark.

just my .2 cents since currently I don't work on
vfs stuffs.

Thanks,
Gao Xiang
