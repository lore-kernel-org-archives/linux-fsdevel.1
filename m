Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D83B9DB7;
	Thu, 19 Mar 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914285; cv=none; b=Hd4jxCQmTnjtgMBAb8lHqWMaBWCSnltizRbetF8Yoir8BS6Mtz3RIpMErecxE9Suy1BSPhvYIq+4kRwQmNlkkKwrLfYYbDqWBmnkwYj2EEx9tcK0pit08GPyy9SnZu+HUO/+Ze/j3/vM4wYlbJZ8gn8vx3KQJ8SSrW3p00zHd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914285; c=relaxed/simple;
	bh=t48Fg25qQ/qZqlFZfEQwNnkVUfSYqyQS/wDhTgVLzc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdFNRt84GJ2Zm+JTyUckjWShlY/wqtAZTVJ9AcRHqgUPhyW5mEZsQkiLoreCnxvd0e2EylUQXN5yvoQY+nYI2+FwQqvEC+SaP73GddAYnb2VQUzOZilQtOTPvOnVY4j1nk26/N34y/L1vsK9ViN6xXZJ5wa1TtrzMl6nqk5KTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62J9vJAs046956;
	Thu, 19 Mar 2026 18:57:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62J9vIsG046951
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Mar 2026 18:57:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
Date: Thu, 19 Mar 2026 18:57:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
To: George Anthony Vernon <contact@gvernon.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <absr9g7LaMEHfw47@Bertha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/03/19 7:49, George Anthony Vernon wrote:
> Tetsuo, what do you think about doing your check inside
> hfs_cat_find_brec? Something a bit like this:

Currently hfs_cat_find_brec() is called by only hfs_fill_super()
with cnid == HFS_ROOT_CNID. Are you planning to add more callers?

If no, my patch

  -		if (rec.type != HFS_CDR_DIR)
  +		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))

is sufficient.

If yes, your

> +       if (fd->entrylength > sizeof(rec)) {
> +               pr_err("Bad catalog entry size\n");
> +               return -EIO;
> +       }

part is not compatible with https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/super.c#L359
which requires that fd->entrylength is exactly 70 bytes in order to make sure that rec.dir is
fully initialized.

  sizeof(struct hfs_cat_file) = 102
  sizeof(struct hfs_cat_dir) = 70
  sizeof(struct hfs_cat_thread) = 46

Even if you are planning to add more callers, my patch will be easier to apply to stable.
