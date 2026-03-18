Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3719365A0F;
	Wed, 18 Mar 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830609; cv=none; b=AAmX1CN1IzfwEJOBn1YX7Sjafj1KJwM6Jp0Q2foEjTVttcDMaDoOYQjXU4rCNBl4LlL7tnDnu5r+Ut4qoxxwJRszbrA5gv8gQM9Fj+iZkuuWhVtzi0EDOZVfriB8ChXFPG6s2OFhnGUGQu6auEo25E6nkcsoyefoBJPlD+qx/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830609; c=relaxed/simple;
	bh=wJDoBNPmeUz8Ip/hWh9uN6XY7qsp3PaYOpEaWOERkT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIBwDQ6bD1FbgGob2Hce6KRUBXLHkWCOICwZdZbVrrV5XM5tskmzkaqWkYsDnQ7oRzCGwVvHfna0hpx84fiOQUm8/BJmVH8RpJd5yb2csa3uGaJek2odMKZdTKz5uf6Ey6MM6LqeyZYmlWHGWRw71UC3liqCSXgnNFO6GF2l8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62IAgj2P064322;
	Wed, 18 Mar 2026 19:42:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62IAgiu6064315
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Mar 2026 19:42:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <273c9764-dd16-49e8-80e6-bfeea87fc0b6@I-love.SAKURA.ne.jp>
Date: Wed, 18 Mar 2026 19:42:42 +0900
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
 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2026/03/17 6:50, Viacheslav Dubeyko wrote:
> It means that, maybe, we need to add the logic of checking the extracted record
> by hfs_cat_find_brec(). But I cannot imagine that this logic can extract the
> record  with incorrect CNID. Because, it is the main goal of hfs_cat_find_brec()
> logic to extract the record that contains requested CNID. And if we requested
> the HFS_ROOT_CNID, then this logic should return the record with exactly
> requested CNID or return the error code if such record has not been found.

I can't understand what you are talking about. Since hfs_cat_find_brec() is called
by only hfs_fill_super() with cnid == HFS_ROOT_CNID, we could remove cnid argument
 from hfs_cat_find_brec() and rename hfs_cat_find_brec() to something else.

What we should talk about is not hfs_cat_find_brec() but hfs_bnode_read().

Although hfs_write_inode() does nothing if the "rec" contained unexpected values

  https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/inode.c#L499
  https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/inode.c#L522

, it seems that the "check if we can read requested length" => "read the requested
size" => "check if the read data is appropriate" pattern is the expected
hfs_bnode_read() usage. Therefore, I consider that doing the same pattern for
hfs_fill_super() is reasonable.

  https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/super.c#L363

