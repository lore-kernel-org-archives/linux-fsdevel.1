Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97619D074;
	Sat, 14 Mar 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773470146; cv=none; b=dTPWaNakk9nNmqZ0N36wBDtvRZeyBzRhi1Oq0xjr+3dQhgJ7x9gLlPpmnyqXOV80LollgrIsn28N1vmJrKT+2qPoN2C5h7hhulsS41SfO42vIvRfF6SK9mEoxSzrTdxSzFDocRdvQG4Tc9NONDk1DDRzVhVdRRXhzh+be/aaKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773470146; c=relaxed/simple;
	bh=8LCbvjwHAn/eARne8q5KNrrDj4RhGbAQfAylSyGydbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDDI730pik4y6doi4ihHCdlgGqHkwE0Lv5X/vQY6puMMbJLDMocC1TitUIUgxTREU+N2KK9f6MMYYMShcxKyk3orRZgXeIdM4lkeuCZHBWRwy0zGwzpBT5e2aDP1PXvc/HwrbnWxqacj1IzFUACt37TRxpivxQR+b1AbV/pn+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62E6ZGoH028886;
	Sat, 14 Mar 2026 15:35:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62E6ZFc2028879
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 14 Mar 2026 15:35:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
Date: Sat, 14 Mar 2026 15:35:15 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2026/03/14 3:40, Viacheslav Dubeyko wrote:
> On Fri, 2026-03-13 at 20:03 +0900, Tetsuo Handa wrote:
>> On 2026/03/13 8:13, Viacheslav Dubeyko wrote:
>>>> And even after both changes are applied, my patch still makes sense
>>>> because mount() operation still succeeds for cnid >= 16. :-)
>>>
>>> I don't follow how it could happen. Please, take a look here [1]:
>>
>> Do you remember that you said
>>
>>   "Why do not localize the all checks in hfs_read_inode()?"
>>
> 
> If we still have not correct implementation of hfs_read_inode() flow, then we
> can make it right. The patch is under review yet and it can be changed.
> 

Did you read relevant commit in my patch's description? What you have been
failing to understand is that the value filled in by hfs_bnode_read() can be
corrupted, for the value is given from relevant offset of the file system image.

>>> We request to find exactly HFS_ROOT_CNID. If root folder has another CNID, then
>>> we simply cannot find the record for root folder in Catalog File. So, we never
>>> will call hfs_iget() if we cannot find the record.

Your assumption is absolutely wrong. We request to find HFS_ROOT_CNID, but
there is no guarantee that the CNID value (the value of rec.dir.DirID if
rec.type is HFS_CDR_DIR, or the value of rec->file.FlNum if rec->type is
HFS_CDR_FIL) which is filled in by hfs_bnode_read() is actually HFS_ROOT_CNID,
for the CNID value is nothing but 32bits read from relevant offset of the
file system image.

Since we are passing wrong CNID to hfs_iget(), we can't fix this problem
by updating hfs_read_inode() flow. The correct fix for this report is
"don't call hfs_iget() if CNID is wrong". Your patch can be applies as
a further improvement rather than a fix for this report.

