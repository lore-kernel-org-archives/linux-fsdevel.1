Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860F37474F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142257; cv=none; b=NFDHFlvmVTGvCoEuiDvoif4p94Elp1WE/2+04hqq6lnN4xnn+fmFtLgErog96BQZJDDOsElEi7TnqWdncRuaJZvoRTNPbUmX8OZCkvfJExw42uS6AlN83OVL9fqMEVP7A0Bm7GYzxwL4Ls5UdbNlMBU8gCOKXia2zFu95YxTELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142257; c=relaxed/simple;
	bh=sEsWcHgB8fBsLYNc2GzuXanZz8pp/VECNSA4uM99Jwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL6myLvM+QqIu9JGdD0XbzLlYms34QiwNlkpS527OHs7yhrjJnctrl3fXU0gGdHXoDzoBbZdnJTOJAcmXxebuDjhohk/lFGMTjKczhJ9tdmR18TPumaIiOP4N+HcoWiihzG2dnPvP2QhuQIwR1ZnKWX/X4gudpF1McqXcvRVW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJmjJNk5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJmjJNk5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358dff8447cso1330709a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777142256; x=1777747056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuIBH+fxyHNJoqJ7NMiUdeM/jy8yW1F801oZRw2MS8M=;
        b=EJmjJNk5/jV1EHa1vsl1ka2ep162GBi9MJ4DR8lyhrylcvLHQYE0wIOXHqyAENeaEG
         qC/Eg82eXCxOuyD2YKvZ59YhfldWoaDpfkJnwgXJl7pgGLy5gm0P+iTbwXmSUfMXzP3w
         KGcgNISj2rvB8U6W/DAuWVUT+DF+iJjJJTyQ1isbPRUjcazW+3lzjXgwBZ4HFm0VGYq6
         bOuLiQX4wPWeOqXL7NAdbVbI6KHvpY7NcCH3EvMl9iqhVyZ+ltKaVLj9vA2OjG2rAOXb
         cZTijxqySqwY91SFAj+Y1OydvT8/DhM7MMsT7vTVoqMN99z7viEIL0FGZqgYd7iHCLPB
         cWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777142256; x=1777747056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JuIBH+fxyHNJoqJ7NMiUdeM/jy8yW1F801oZRw2MS8M=;
        b=MhTEoqDSpIChrT8Pzs6wx4zz9knwxbiICOGAyykfpqkVHQ0VTovzTzgov7WqNjW8FP
         tjWcNQU2BPRIeHLTLTapaeb5Ne6iLOfCLIjQalUvHQUbQ/1VPF8fzWN66GfAgjpFr4SQ
         XKND/9vaE1vmDIzlfycYVjE93yMmRJBzJJuu0dWNnqTc6NaO1/1lUSDG0YmDpU+UcUZW
         uWdXmQ0MkmQwjH27pLFQr118fABF2cPDj6YExBKkjysUrE4FkFQXCTamb61fk7UK5A3p
         HXoRuogR7YGCYakODGt4/PXEp0xl4krwyI6a0TWZbFveF8XJkWWCMEPm3yIfZnwb9p0O
         RcDw==
X-Forwarded-Encrypted: i=1; AFNElJ8Cicv7+Cren9aZOs4urVlBrdqIvQXUMVzXcDshhdW4CV83Fbt33BUyFht3Z2Em7yV3/El1eIThMYLFDI5v@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMGOzb3MzLtIDQV7K/nIHWKU3K+BwNQOwQ3hYWWHoYgMyL3Nq
	qoLkaMiTxeyhtBgq9hcHRfT1sxeGW3xrVIifZvPSDwRLV7z+vUhqpK+Z
X-Gm-Gg: AeBDieu8EGuJjAEYL7aDGG4EtY20X4EpQOjkTEmVQVDCFUlDZ391Jaef6r1pNNK2loa
	2LS3V9OSGls36UjtwPo/800cnGUGBgfCCF2LCvp263gn7CSTcBMvNUjGbjecDViC/ZZSRy7W4IT
	TB/c4nysqcLCD8+/Vf3j7w7X5COUySGXPGQh1kVfV+L+B5DfnKP5jMSVRBndb0Xxktrw8XD+Bzo
	MJFlllDEGiPFbwctI86GyAfVgy2bS7Y+DQT3ksZI5quoiHsS16HbXySzIdRw7vayXIvixj1rxQr
	/DO99jlWDRY7tOsRP0xh2uhy1sJYfPY191pRchf8LI9CPCteSmlKqFwieGQpnKV1+9IDjf9WdAu
	455icwf8reAyH7mjBwPbJSg/rv9kOIdL9tlBZHud1MVNw3dxDWcTu4Uf7WKTnp+OvTv3NTa44BH
	12TPmMsRhUD9DcxpUihgFckuJ9sxbG0Xn1+EAm/A==
X-Received: by 2002:a17:902:b701:b0:2ae:6220:1539 with SMTP id d9443c01a7336-2b5f9f7bc2dmr134909205ad.6.1777142255702;
        Sat, 25 Apr 2026 11:37:35 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20695sm257480585ad.56.2026.04.25.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:37:35 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: brauner@kernel.org,
	djwong@kernel.org,
	hyc.lee@gmail.com,
	willy@infradead.org,
	xiang@kernel.org,
	hch@lst.de,
	linux-fsdevel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: Re: [PATCH 2/2] ntfs: use direct pointer for inline data to avoid redundant allocation
Date: Sun, 26 Apr 2026 03:37:30 +0900
Message-ID: <20260425183730.113450-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423213203.5533-3-linkinjeon@kernel.org>
References: <20260423213203.5533-1-linkinjeon@kernel.org> <20260423213203.5533-3-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Apr 24, 2026 at 06:32:03AM +0900, Namjae Jeon wrote:
> Previously, NTFS used page allocation for IOMAP_INLINE to ensure that
> the inline_data pointer was page-aligned, avoiding strict boundary checks
> in the iomap core. Since the previous patch has removed the over-strict
> PAGE_SIZE boundary check in iomap, NTFS can now safely point
> iomap::inline_data directly to the MFT record.

Just a note in case it is useful for the commit log: this also removes
a pre-existing page leak in ntfs_write_iomap_end_resident(). On the
ntfs_attr_get_search_ctx() == NULL path the function returns without
releasing iomap->private:

      ctx = ntfs_attr_get_search_ctx(ni, NULL);
      if (!ctx) {
              written = -ENOMEM;
              mutex_unlock(&ni->mrec_lock);
              return written;   /* iomap->private not put_page()'d */
      }

Since this patch drops the page allocation and the iomap_end callback
entirely, the leak goes away as a side effect. Worth mentioning in the
commit log -- it makes the change a candidate for stable backport even
setting aside the optimization angle.

Thanks,
DaeMyung
