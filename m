Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2C18872A;
	Sat, 16 May 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778912269; cv=none; b=oxpKiDacaiMKsfih6tNXY5Fh8ndCr/WQZp+OkYpTuDZRolMWo47IGRE8EBeOfYjZkkYiS7WIc8E4a47UTWU3rL7fixL0UYHxsWgxV6DHy8vDRvgHuAp0dl1ugkC0mUPRpBxoeMyAsBDyLgMfwuN9cLr295Rk9o1oQ6+ZskAr59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778912269; c=relaxed/simple;
	bh=Jy85tXngzyQqbvPMxOTGHJQI1fggE/SuVukvCwx7GXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHDaEaVlK6KLdZ/o2faVls58ZPy0Wkncf8Qp+RN8TJZLCYLwyrnhEUkbnd6aqnfXZPMBGzH96l6xX5pxHLLbVxNQdwvGYMg+x1/RHbUymfKxCdAf1kAnd0Rp6NLkuezj8Hd7DmRW7tpvlOxQ1dz9oR58lWxabSOPSgZHpfu7SXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64G6HGeN079887;
	Sat, 16 May 2026 15:17:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64G6HGQ0079883
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 15:17:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7c54e697-9a96-4304-826e-8a437218f5e4@I-love.SAKURA.ne.jp>
Date: Sat, 16 May 2026 15:17:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] hfs: validate record ID against requested CNID in
 hfs_cat_find_brec()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "contact@gvernon.com" <contact@gvernon.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
 <abnzsVk9JNN3alKq@Bertha>
 <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
 <absr9g7LaMEHfw47@Bertha>
 <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
 <070d92639460b672a174d6a11b1e7d0b099b18cb@gvernon.com>
 <9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp>
 <c80f3c36-4c66-4e51-ab3e-e83d37b60131@I-love.SAKURA.ne.jp>
 <5ff5f107e5a8588367b3af77748369c166f16cc7.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <5ff5f107e5a8588367b3af77748369c166f16cc7.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

On 2026/05/16 6:10, Viacheslav Dubeyko wrote:
> On Thu, 2026-05-14 at 16:34 +0900, Tetsuo Handa wrote:
>> syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
>> operation when the inode number of the record retrieved as a result of
>> hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
>> commit b905bafdea21 ("hfs: Sanity check the root record") checked
>> the record size and the record type but did not check the inode number.
>>
>> Initially, Viacheslav Dubeyko was assuming that we can fix this problem
>> by adding validation to hfs_read_inode(), and George Anthony Vernon is
>> proposing a patch that adds validation to hfs_read_inode().
>>
> 
> We can fix the problem in by adding validation to hfs_read_inode().

No, we can't. We can't fix a logical error that hfs_fill_super() by error
accepts an inode which is not the root inode, by adding validation to
hfs_read_inode().

> 
>> While I am not against adding validation to hfs_read_inode(), treating
>> an inode which is not the root inode as if the root inode is a logical
>> error which should be rejected regardless of whether we hit BUG() or not.
>> And we confirmed that we can't fix this logical error by adding validation
>> to hfs_read_inode().
>>
> 
> We haven't confirmed it. The issue can be fixed by adding validation to
> hfs_read_inode().

We already confirmed it, you forgot it.
https://lkml.kernel.org/r/b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp

