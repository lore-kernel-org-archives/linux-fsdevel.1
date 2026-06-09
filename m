Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464693BF67E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977257; cv=none; b=hWqqkQq8hsNudlq6bWGfCM0lsl2jk+Pj+qHMqyBuhqZVHNwJoXHBAv/pfW9G6ud11AcZcJRs/XKjgVOstTgQzOos8Jz4LXlWSuNPX5ZZrtmaj8Y+Ns/0E/YX3BO8pkmIKtWSCwkGZoTSuK19WjED1iarksYEtIYw9SkUlqOICmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977257; c=relaxed/simple;
	bh=mvpNFxgw5BGlOhcYlxQ+uaTZqopDimKnKLAb8n4GHt0=;
	h=Content-Type:To:Cc:Date:Mime-Version:In-Reply-To:From:Subject:
	 Message-Id:References; b=tWKL4jAepH2MTPN5EDFQySYDt/16s9y4rndtMJ+u3UzcMckJm75xjKQ8xcuEbcncmXDzICPnYvRmuuz27uV7uEonCWSSRQA4rzm4FLIn0vldNIieqIvloxms6lCxRqeQ7IRult5H7oO/czOVyGlMtj9aoJ6XAImsVDVNxXhTwTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VN+P7Oj6; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VN+P7Oj6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780977252; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=uo5KRq4o05V/cFeWp3gjQe2Ro38rU4Ok5QFUlwdMpL4=;
 b=VN+P7Oj6CZSHSm9XIHKHle7jlX2kAOrwpY5q384R7Aol+VmaMTHNzjmmQFZXx51pwNtwb9
 H310Yliqx+Mlzh1fZqv9UmfNP+zg9i3C9mZvdZbPKn7ui2ug9PI9zNqkD59Z7IC3Zgit+Z
 viDci5onMfhmpxkX4+pIMX4ctDgbBrcv1gTqpimiFdiPOXOV+oBIuVonuKEePwjYgl+inD
 7/nBmIiOtHQC48b3FeGUOqMz8HBMNui8oarw9q8jc69yaj6lv+S7IjqkXiwI799aUUSIsy
 3J17AaMT0TlicihCsv+Cjpm5JoBjsgCxE2Q4tsfxA+19vC2IJsuBeUoCcZRrhw==
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Jan Kara" <jack@suse.cz>
Cc: "Jia Zhu" <zhujia.zj@bytedance.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Andreas Dilger" <adilger.kernel@dilger.ca>, 
	"Matthew Wilcox" <willy@infradead.org>, 
	"Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, 
	"Baokun Li" <libaokun@linux.alibaba.com>, 
	"Ojaswin Mujoo" <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani" <ritesh.list@gmail.com>, 
	"Zhang Yi" <yi.zhang@huawei.com>, <linux-ext4@vger.kernel.org>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Date: Tue,  9 Jun 2026 11:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <slupx7cfhq4uuk5bd3xnzu7ybnnqghzrseg3xjao6x7tbj75v3@jxv32j4em2cu>
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Subject: Re: [PATCH v2 2/2] ext4: avoid tail write_begin walk for uptodate folios
X-Lms-Return-Path: <lba+26a278e61+d15204+vger.kernel.org+zhujia.zj@bytedance.com>
Message-Id: <20260609035405.92959-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
References: <20260603134800.25155-1-zhujia.zj@bytedance.com> <20260608120131.45146-1-zhujia.zj@bytedance.com> <20260608120131.45146-3-zhujia.zj@bytedance.com> <slupx7cfhq4uuk5bd3xnzu7ybnnqghzrseg3xjao6x7tbj75v3@jxv32j4em2cu>

On Mon, Jun 08, 2026 at 04:29:59PM +0200, Jan Kara wrote:
> You simplify this condition to:
> 
>   block_start < to || (!folio_uptodate && bh != head)
> 
> With this updated feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan.  I've applied this simplification in v3 and added your
Reviewed-by tag to both patches.
