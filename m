Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4303B19B9;
	Mon, 29 Jun 2026 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726034; cv=none; b=JtcVddNkRiqgdyWwRhuB90UsIrDLsAA7XxpKRihpIBkTKHyfWcQIrWsdx4Mx5B8rLYq4mummGhuQO5m1gT5XovfszJ0DHPQiocHPhhpp86F4iMCp7rzIXtOth0d2JuNv1tl3ao904CMNWqZjZ1UC50qJtvl/bI6ca8oR1mUeCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726034; c=relaxed/simple;
	bh=37KETMUTc5xeBt9g1+XXfGXRhGh0sPVI3NYNnyE1UGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjHh8Q21emqkNYqvYgYnL0SMUYZPXLQPVzuyWcoVB1NRI8wdcVcIz/qiqsQdVJGdmJV7HCsiy3injN/qtz4NBi8VoWog35EatxdW3XaeWqwrSWjMvi96icPefh2A9p39q+qHfuEpKL5cyt9QOVP2CO7P17L9BSjTQCi41PQG0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=nWHm7/34; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="nWHm7/34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782725985;
	bh=1cLz079p44E3BLMheqQckuVZaXbDtFvod6nuBviQRS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nWHm7/34QHDYbP25BNvtY+d3n349rgnoAaoLJozoaxo2C5HNcYLxyUf4WilmD2+Tq
	 FCPF+TM81RZ5/ekU+Y+zQETygmX2m6vAdR5nld3bDl8JUKgk9+tr5k/H5BWY+mYFQG
	 NqolsRcNq8EdoYsDYEBRxvDhtKtpT23e808EhBCQ=
X-QQ-mid: zesmtpsz6t1782725984t775bdeae
X-QQ-Originating-IP: NOYne1Z1e8TZIUFvaBYWKSP9RkeJe8BRpocwyU+QKeo=
Received: from [172.27.139.54] ( [218.94.142.77])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 17:39:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17125133871365925860
Message-ID: <394DF429DB89D1ED+3cf8c72f-31dd-484f-9324-8e4d27a6a7c2@smail.nju.edu.cn>
Date: Mon, 29 Jun 2026 17:39:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ntfs: mrec_lock ABBA deadlock between writeback/fsync and
 rename
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: hyc.lee@gmail.com, syzkaller@googlegroups.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <C4D296F0E9F3D66C+9397ffbc-eb55-44bb-9b3f-5da4809e7955@smail.nju.edu.cn>
 <CAKYAXd_XUHGKfJsZpZ7ZGpe8icvJZRWrjuU9D3H3XgauYhV_Ow@mail.gmail.com>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <CAKYAXd_XUHGKfJsZpZ7ZGpe8icvJZRWrjuU9D3H3XgauYhV_Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M6jCEqzRSimEtimxTxX/HH9O6xTnhDM/PkIz1FwM6PF10Vcx+NbihKOE
	eD1miIlL7YjDwq2NHSnDhKVdt/wP+GYuedYE5x5oaAByRgvTZmVd+hlwjurOftWPfLHicrN
	QMSFp8scsstPSguuqKDypklmvl1RI25fWyP0Nfx6gRjxBf+Ii5/P5VIaPsit4xpfQyhOoBq
	1AdWO5fHoP2eJF7Pb6n+lHXZ6rIRR/1NnNL9Ny/iFrIcEf9zy+X2ZLCI9gR72dPoPysMjlC
	hBw3/4bdI3iN02N55PHnkHtkfLMqhG79X82ek6maQ8JaY8Pc8GAFfG1FcrOCZpetuc0JJ3O
	SixLdBsfunpm03cRxKxXtlW2GfvMkzjEOjdmNjFp0bvYTNELK5XykDpNcw5GMW7hMSXdmxe
	6yYE+ENpxLafl/5RwxPemUmV5cTFP8dZzBG/+ierI3uHjG/E6+VAOfCu+BPKncJ8MrBiAUW
	E2AHATm74de2+URXoYPCpPCrNncUQFOT/WOrVUXFSuuZUaeXrXYHVtOUSD/Hv6v06U8ySGt
	YWQ3IIuFYlnPSAhX7XnSIt2MWUhbHWxK/upqbD0noL5AJC8h/65lTbOJXl7uMXqZ+i+ZUJm
	FhTX72zFJ51FyPGR59dAPxS04l/Y42/1pKdiUyrcyCKncX7lIercEGTnfe2RfJ9iddnz4F3
	9so8IDzBIOOW9Fw9bofStS9RI++81y2jpugNlSfSdRCVsNMAt65EThdA2H9u8YrNMqFsOrK
	pEc7RQnv/5ew1DIRxA6a+02Ls1tfHljw9al556O3GMJTssf78I0INzikP+udkbDnVXwAAfO
	VCmMdkRIK0LbE4+fIdrSddtKB8ljsiMuC9R0sgixx0j5775vIsVUODkj16r+nvUG0tbHW99
	sksAFD0ZhDnU2KNALnh3wegX7lY7iSEZmFn8PgJZqszXDXatC2vED5mkaxBYqRA4SV7EE/G
	bgl2X0rkwEJrvIQry47fQuPg8mLghx2qnP9Nb2+ef7ujj7dRGNOFv1p6zNrDWM8v5fi4P5b
	i4RllZaoCQdYXQeHU0+0gCmZNPDdgW2ie5QWTXHM6fgAt0xVeOlLw8DYGs/FJ9pqNnyXwqd
	U0ctmXt3BfDMLc0vlG5tbs=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On 2026/6/29 13:18, Namjae Jeon wrote:
> On Mon, Jun 29, 2026 at 1:25 PM Peiyang He <peiyang_he@smail.nju.edu.cn> wrote:
>>
>> Hello Linux kernel developers and maintainers,
> Hello Peiyang,
> 
>>
>> We found two task hungs in the new NTFS when fuzzing with Syzkaller.
>> After our digging, we believe both hangs are caused by the SAME AB-BA type DEADLOCK issue,
>> so we report them together here.
>>
>> Title of task hung #1: INFO: task hung in __ntfs_write_inode
>> Title of task hung #2: INFO: task hung in ntfs_inode_sync_filename
>>
>> Kernel version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1).
>> And we believe the bug is also possible in the current mainline.
>> Note that the code line numbers in the following analysis are also based on this kernel version.
>>
>> Relevant kernel config: (the complete config is included in the attachments)
> Do you have a suggested patch you can get credit for?
Hi Namjae,
Thanks for your reply. Yes, I'm working on the patch, and hopefully I can get it done very soon.

> Thanks.
> 


