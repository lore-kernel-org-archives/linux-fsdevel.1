Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A184035C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541527; cv=none; b=iQl7aW21C5fLUlCf5sabCoY9wI/te55RZrKLhesG7ugrCUJocXvW/PI3OgNw3iDeCqxIF62Kugwv4g2jgWbKZLOEtGn06HarKbgYZq6WkEKYHJH9mcRwZdspA3tvmDyp0hqNzi2sNqQoeB7c5TYmKJdedj/sGQ2ZClgh26Jla/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541527; c=relaxed/simple;
	bh=1tMjbbLh64lH3/NizWu/5nG4JnDPFE8TunsGcn7k92k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L58WL0YcrObUQMVKJR6SRt3Cf02ZW9/HNjSLvszfgDT7P+ut3Jj8OzRkeEA+3ODmaYLWlLPvPjQxg2ahLize5kfWqnODWRW1eAhe6OHAbU/56XC4Gmgh6ToyIGF8bvwKHeFXzn0nqqs34f90cLfEkTRwIL91nMTLePWL4ci/K4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ESOORfbL; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ESOORfbL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774541522; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=4KAN8eUFbexQTQfptrVugPh5LThYs5FLxuL858YEFlg=;
	b=ESOORfbL6NpTNIRYLWu1eRglYO4qAimjOhrPN33A4XhmdszXNYU4xY3UfaPTNsnYZEmW7CB/EsHgFAl6U8ootEHFJ4sjVQoBoF/RQQL70FWbh4UFuwTPjIkBq/FIq+5ASeg74DfmhVydG7HESHD9sCkZf0/sgita9beahE6lb+g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.lbbxC_1774541519;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.lbbxC_1774541519 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 00:12:00 +0800
Message-ID: <0b8a0d24-1c20-45b3-abd9-e95b3b4d4caf@linux.alibaba.com>
Date: Fri, 27 Mar 2026 00:11:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Jan Kara <jack@suse.cz>,
 "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
 Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>,
 lsf-pc@lists.linux-foundation.org
References: <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner>
 <b8f5bff1-27bf-4934-9297-0aad551a550c@gmail.com>
 <d2d5c218-7063-4ea0-ab03-1433449f4d83@linux.alibaba.com>
 <20260326-gemindert-vertuschen-fd3a507eba94@brauner>
 <f1cef32a-1c35-41dd-88af-a8c504d41a93@linux.alibaba.com>
In-Reply-To: <f1cef32a-1c35-41dd-88af-a8c504d41a93@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/26 23:10, Gao Xiang wrote:

...

>>
>> I don't understand what exactly people think is going to happen once we
>> start promising that mounting untrusted images in the kernel for even
>> one filesystem is fine. This will march us down security madness we have
>> not experienced before with all of the k8s and container workloads out
>> there.

Yes, my reaction about this is that still depends on
how you think this.

The whole Linux namespace mechanism is unsafe compared
with traditional virtualization; no one really imagined
the implications without implementing, enabling these
namespaces and trying.  These new mechanisms introduce
many new CVEs and vulnerabilities from time to time, but
containerization still drives innovation, and
cloud-native technologies are heavily based on it.

This is especially true for user namespaces. However, I
don't think we should remove them entirely from the
kernel just due to potential CVEs or because they aren't
implemented in Rust, for example.

Regarding FS_MOUNT_USERNS, my experience over the years
is: three years ago, honestly, I never cared about this
feature at all. But soon after, several new attempts
emerged to resolve the same requirement in different
ways, which already confused me. I wondered why we
couldn't work in a cooperative way instead, especially
since neither of them looks like a very huge project with
enough development resource. Then, I realized that as
long as you don't implement something, there will be
endless new attempts and comments from various small
group of people.  And the userspace policy will never get
in agreement.

So, if this is filesystem-specific, my current thinking
is this: if the security model can be formally documented
and fuzzing is improved, could it eventually be enabled
via an opt-in Kconfig within a single filesystem group?
Would that end the whole story because the Docker image
requirement is fulfilled?

Thanks,
Gao Xiang
