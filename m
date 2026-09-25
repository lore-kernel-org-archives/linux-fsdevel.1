Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C9296BA9
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790310523; cv=none; b=hs9qTHevezhpyX8mVT5lKOfmBcZ98jO0RscHy22dIOFesiKzTMUnel230pbkVuz1ykv1ytRBmJEtOxGf4hbyoTLLIUmBi88pZyI6Ar3j+l2UiAAAPhjrgXnpCBsL0hRvz1d1d4aM1xGUjRULIAbzXG06Tqy4y8EF+dMN6QYwg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790310523; c=relaxed/simple;
	bh=xZjyaOWxOWcGWoOLJQaxRromtWcHBUc3cBhfH4gXhFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC7bFkQ3aFmQRco2AORGRHNA3hFJ44wXY+RrKMudiSbbouUs+gGZkou4FavqXcuoHMLpx0AAiKwtlxcUU+YzOU9f6cBnSkyBtM/HX6KQM8KFVIbGGf7hYxhuvwpOFdtFa6V4UpIhBUwfP+THqYxJwIz7fnsgtFl2SMZc221Jic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfwOnujP; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfwOnujP"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3381a6a05c9so225072eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 21:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790310521; x=1790915321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gZh7+8nC/Wfeh8KZZ/1HMZ53Xwij67r5K1kV9FvBo0=;
        b=GfwOnujPuAwh/mlKhoBRfhF8wOYI7C1NRoUPjwi6ksvDz3oU1sYvRC34t7HhGrUFWB
         VgSqoWqnZwwGF2WpvbTtWR/KrOGG3rdaMd9wgrzf8nvTpK7D2AJpZ5e5vVo1yP3e+LEK
         AYrXZB0yLmfwXFDNn5HjmV3PsUmeoOUMufvsG9MjxkXwrQTYgcpvdBrUyrwJYuUFAjHr
         DfSlGnXDdT7xpmjkQQLnUtjhIOSccWYlol6ACrqvHwYXXbls3R7sDKkmtM6nGHhN5qQg
         NpjooTokXLK5RdqLg5BAbWkQdZA5GxF5pVZb1KZkapmkP9u+ANjkOT+qlv3jmrZ9dL5D
         u7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790310521; x=1790915321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gZh7+8nC/Wfeh8KZZ/1HMZ53Xwij67r5K1kV9FvBo0=;
        b=bW9P/JphaQfQRnitP+o9zkA5TR1kkw6uO7I6m+XKYQ0SmxFD+aEBFxNDF3xK/2VV82
         qFhawi9+W1XtSPZv79Ovmw95bLvPOZNZN4Og/bfEUwJy91CM3R0MD8H06WIakvbgVgG2
         Ni7qtBVFb5msaR7wKkLww3ufmutOx9u87rRcempRXb+3rPqm0gtUCHWXAf4HBRKX2MY/
         mqxKWENP7ZZMYTSdXpoznq5lxI1fG+lmh4fWkfvprxMndowCUyqOql6MocctDThI0EvP
         1fd9/Be9Keq+iQHWxVYoZlOtvO/72XA4Zo8b0YEf7eaVyDtlF4oGxvjOytNZEpgWsuDQ
         7bag==
X-Forwarded-Encrypted: i=1; AKwUvBwUKy2OMNTjI7ROSbbygcHnBJi0DDwUzyKFs5wfSGftRQiJd4O9MERcpsxPDfkqCpkZF7roSwA4ooyirIv/@vger.kernel.org
X-Gm-Message-State: AFuF++mqWcKFw89DjVGooGeCyWoflpxmgK2SYC0UjF7OqXddazXlSE+W
	VLhGIjvIxX91K2es85CapJDA0YdQ3zqR8uezgxB3/DoODbZVbaLUCMMe
X-Gm-Gg: AYBFou17eIlslCmU0HpzuYiA9Q/08wQsnO9JsyScEG72rkkJTGTUYlkcIWC8rfHvdfW
	lDQByA2dawabAjmljaBbJMK6OoRKX7ayBnAFr9olXnNGmFwrk55U3e2C+FCP9QRGo+4Xkxk1lff
	LOuPFkXB2IznMQztEQBuO7SpyJXdcK/Wb83s+dDqfdfvHdJFWkfyygtyKNz9a8LTPjeXNkmL1Rs
	24/lzMBY3h63nF8jG4673CJGKb+QCMZ3ppXvD5BWzz4Y/Bd/3gKdnfqgHUOKg7uedOdOGtPJmUn
	7oLFsMkAvIywG6AU4eGQImr17XIY1atnlUx1Wq9vE35hzweRw2cbI/AlmjdLoZ7hmNRbfpHHBTF
	bomVp7bmGTlwI+WdFPvl+CFObGMNHzeWkPo3JUu5Aiu5eU/p0KaswRAI6Iu83rUbgf1rW5Y0hw9
	u0deizpr8Kqxml7m//F6XMi+Ve5fb+KwsJP2VSEgco4sAFSjNnGtm3WOyFWMdh9ppfXnd/MMn2x
	pj+kLwcm0E1VFPB3iMscvkDUtUWLiWCIURoclSwxIL3gZgtwB36sXIi5+/MuTCnbGTdI/U5SBjv
	7tjFUvXgNLQyZz3VJuzaFAWo1gnQcczAmZcLz6hAsjeq5YraULJAlShGhp4=
X-Received: by 2002:a05:7300:f80d:b0:33c:e82:70c7 with SMTP id 5a478bee46e88-34000c26cfdmr3331790eec.30.1790310521000;
        Thu, 24 Sep 2026 21:28:41 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341459234a1sm3087155eec.24.2026.09.24.21.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:28:40 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: jack@suse.cz
Cc: scdbackup@gmx.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: Always advance to the next block in readdir and lookup
Date: Fri, 25 Sep 2026 12:28:35 +0800
Message-ID: <20260925042835.1974673-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <vjb4g4xyuare7b6w6lwtbuijboeqhrzdo4vboi7fgpyeu4prtx@gv2zvtsbae6u>
References: <20260922121912.2258134-2-jack@suse.cz> <20260923153134.771632-1-matthias.goergens@gmail.com> <vjb4g4xyuare7b6w6lwtbuijboeqhrzdo4vboi7fgpyeu4prtx@gv2zvtsbae6u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

On Wed 23-09-26 18:55:11, Jan Kara wrote:
> Just I'm not sure it is a realistic failure case - that
> would mean a directory would contain full block of zeros which I don't
> think can happen.

It does happen on real discs.  About 1% of the disc images I checked
on archive.org have directories that end in a block with no records in
it, mostly from Easy CD Creator 4.0 to 4.2 and Nero.  On for_next
(c8437ca3d438), readdir and lookup in such a directory spin, and stay
stuck after SIGKILL.  This one hangs with default mount options, as the
disc has Rock Ridge and Linux reads its primary tree:

  https://archive.org/details/itsoftcd-39  ITSOFTCD 39.iso
  /PROMOTIONS_SOFTWARE_39/AUTOFLIGHT/DISK13

With my patch on top it lists correctly.  syzbot ci hit the same loop
on your patch, and neither of its reproducers hangs with my patch:

  https://lore.kernel.org/all/6ab5dda9.80e1c6cc.1e8e5f.001f.GAE@google.com/

Thanks,
Matthias
