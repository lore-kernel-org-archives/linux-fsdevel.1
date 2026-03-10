Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76617374160;
	Tue, 10 Mar 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139296; cv=none; b=HnloKijvF4L7Eog7Ht9/vGzPVwDr4uqbRv2ec9rt8TGbEHqy1QhXYHM2YjHdOsjxLub1BK75NEVA85hdYOXwol38vk8saIQZDXp4jnIH7di0tDmVLYtPwfc6+VzrLIlHsQtWTibGHeEcBxwgjNCyNCFUzlg7Lx8QcFQNUkgXEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139296; c=relaxed/simple;
	bh=7ENjracQM/5LeM9DMR9ScsDdtUigMf50Q9e17BYPt90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuzYNnj/VDCu8lyGenH2InFc+M6XeBTphbpcfC1ytOhvedCogFeuW0ab7ImWXRvsslkymHAWhf7FT6lFRpxfRJiwZZOlaOl1hOsO/JgANYfPvhWWLkR5W2G5v8PNCmaqvC7Qu7Mb+pWmL46ZdERUlXgvsCTN5gB8hTZD3gOaDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62AAf6lO068324;
	Tue, 10 Mar 2026 19:41:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62AAf00s068288
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 10 Mar 2026 19:41:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <57f080c6-a02e-4308-80e9-523bc757cc73@I-love.SAKURA.ne.jp>
Date: Tue, 10 Mar 2026 19:41:00 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfs: Validate CNIDs in hfs_read_inode
To: George Anthony Vernon <contact@gvernon.com>, slava@dubeyko.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260310000826.242674-1-contact@gvernon.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260310000826.242674-1-contact@gvernon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp

On 2026/03/10 9:08, George Anthony Vernon wrote:
> - Remove Tetsuo's additional superblock check from patch series

Why do we want to make mount() succeed for CNIDs other than HFS_ROOT_CNID ?

  0 => EINVAL
  HFS_EXT_CNID => ENOTDIR
  HFS_CAT_CNID => ENOTDIR
  All others => succeed

Fuzzing against unreadable root directory is not useful.

