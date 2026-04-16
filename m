Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EF21256C
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776343306; cv=none; b=G+RqT236ajvo/1stJqFSvLSKknikoj2HQ0xrlAujz7l+jdfuOzhpVgKOEVro7x9oS7QLzkwFD8KKWCeIMoHXif/McKbcK069NhppGf5vny+XHrML/qk1vjZDLnQ9WeuaLWbSZSmUADsaGg10wNsyEUUvhszpDgbaLcI19OqpPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776343306; c=relaxed/simple;
	bh=xgE/u8OXIYWm88UVDmVHjXacEE13SQd6bJfoP5mUiD0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=VjOIRNv8QxqzM2niy5J5RhKewhR33TNrFB+d3Ft4TBIXusOXeZ3/N1huQ2E1Vb+XPjRE22gMWxb15HWXbCgDAD8SvQI+QXLFYafF4wW3pn1evMy2EyH9mfDQygUh91H+5L6iA+F/GzHgbk6Cm1KTy2QK9b3uIaI0Nty6tP3mW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=J1J5BJtX; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="J1J5BJtX"
Content-Type: multipart/mixed; boundary="------------PBWAN3Bbi1100Ta0o8JUsV1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1776343302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpJDpjvd754lZqTJVTbKzY3+WbuscGrA+ZFXy3r6Kto=;
	b=J1J5BJtXHWa1d4QPJyoCDsnBwpevNEU3KBLF2+Dqp0dZBWtzoXUUA+CERjGgfkGjV5zx+Q
	G0CvVdo+Ow0eUyTRjmTB1q3VBQBTSWmaQEVPTO4Bo7TZFrGaKByzrSWkWXaSuUDPAQHK2w
	tkNBLeV1iWbfcLfHijgiNpMUToVLZGA=
Message-ID: <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
Date: Thu, 16 Apr 2026 19:41:37 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>
Cc: fuse-devel@lists.sourceforge.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev,
 linux-mm <linux-mm@kvack.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
Content-Language: en-US
From: Nikolay Amiantov <ab@fmap.me>
In-Reply-To: <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>

This is a multi-part message in MIME format.
--------------PBWAN3Bbi1100Ta0o8JUsV1J
Content-Type: multipart/alternative;
 boundary="------------52NtMlTbHFL7c0NjiV8XF8Yj"

--------------52NtMlTbHFL7c0NjiV8XF8Yj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/26 19:12, Miklos Szeredi wrote:
> I wonder if we could clear PG_uptodate on the page which had its zero
> bytes exposed by the i_size increase?

I've actually tried that first. The idea was to get or create a new page 
on the EOF boundary, lock it and poison it with an uptodate reset if we 
need to. But this resulted in an instantaneous EIO in my test. If I 
undestand correctly, this is because of another race condition:

* A fresh page gets created and read by FUSE; uptodate is true;
* The page is unlocked on return from `fuse_read_folio`;
* Simultaneously, we run `getattr`. The page gets locked, uptodate is 
reset, the page is unlocked;
* Now back from `fuse_read_folio`, `filemap_read_folio` gets this page, 
waits on `folio_wait_locked_killable` (waiting for the getattr to reset 
uptodate), and then checks `folio_test_uptodate`;
* The page is !uptodate, so an EIO is returned.

So it effectively results in inability to have a successful `read` when 
a `getattr` for a growing file happens simultaneously.

Finally, if I understand correctly, this also leaves a (much smaller) 
theoretical race condition in `filemap_read` between checking uptodate 
and getting the current inode size.

Attached is the patch with this attempt; please check that it does what 
you meant in case I misunderstood.

Cheers,
Nikolay.

--------------52NtMlTbHFL7c0NjiV8XF8Yj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 4/16/26 19:12, Miklos Szeredi wrote:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
cite="mid:CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">I wonder if we could clear PG_uptodate on the page which had its zero
bytes exposed by the i_size increase?
</pre>
    </blockquote>
    <p>I've actually tried that first. The idea was to get or create a
      new page on the EOF boundary, lock it and poison it with an
      uptodate reset if we need to. But this resulted in an
      instantaneous EIO in my test. If I undestand correctly, this is
      because of another race condition:</p>
    <p>* A fresh page gets created and read by FUSE; uptodate is true;<br>
      * The page is unlocked on return from `fuse_read_folio`;<br>
      * Simultaneously, we run `getattr`. The page gets locked, uptodate
      is reset, the page is unlocked;<br>
      * Now back from `fuse_read_folio`, `filemap_read_folio` gets this
      page, waits on `folio_wait_locked_killable` (waiting for the
      getattr to reset uptodate), and then checks `folio_test_uptodate`;<br>
      * The page is !uptodate, so an EIO is returned.</p>
    <p>So it effectively results in inability to have a successful
      `read` when a `getattr` for a growing file happens simultaneously.</p>
    <p>Finally, if I understand correctly, this also leaves a (much
      smaller) theoretical race condition in `filemap_read` between
      checking uptodate and getting the current inode size.</p>
    <p>Attached is the patch with this attempt; please check that it
      does what you meant in case I misunderstood.</p>
    <p>Cheers,<br>
      Nikolay.</p>
  </body>
</html>

--------------52NtMlTbHFL7c0NjiV8XF8Yj--
--------------PBWAN3Bbi1100Ta0o8JUsV1J
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-fuse-fix-stale-page-cache-data-race-on-file-growth.patch"
Content-Disposition: attachment;
 filename*0="0001-fuse-fix-stale-page-cache-data-race-on-file-growth.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA1MTIxOTRiOTgyZmQwZWRiYzFkY2FhNTBmYWZhZDc1YjFiZTI2ZDQyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtvbGF5IEFtaWFudG92IDxhYkBmbWFwLm1lPgpE
YXRlOiBXZWQsIDE1IEFwciAyMDI2IDA3OjI4OjE5ICswMDAwClN1YmplY3Q6IFtQQVRDSF0g
ZnVzZTogZml4IHN0YWxlIHBhZ2UgY2FjaGUgZGF0YSByYWNlIG9uIGZpbGUgZ3Jvd3RoCgot
LS0KIGZzL2Z1c2UvaW5vZGUuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQogMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9pbm9kZS5jIGIvZnMvZnVzZS9pbm9kZS5jCmlu
ZGV4IDczNWFiZjQyNmEwNi4uMjA3NDE4NjlhYzJmIDEwMDY0NAotLS0gYS9mcy9mdXNlL2lu
b2RlLmMKKysrIGIvZnMvZnVzZS9pbm9kZS5jCkBAIC0zMzQsMTAgKzMzNCw0MiBAQCB2b2lk
IGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZ1
c2VfYXR0ciAqYXR0ciwKIAkgKiBleHRlbmQgbG9jYWwgaV9zaXplIHdpdGhvdXQga2VlcGlu
ZyB1c2Vyc3BhY2Ugc2VydmVyIGluIHN5bmMuIFNvLAogCSAqIGF0dHItPnNpemUgY29taW5n
IGZyb20gc2VydmVyIGNhbiBiZSBzdGFsZS4gV2UgY2Fubm90IHRydXN0IGl0LgogCSAqLwot
CWlmICghKGNhY2hlX21hc2sgJiBTVEFUWF9TSVpFKSkKLQkJaV9zaXplX3dyaXRlKGlub2Rl
LCBhdHRyLT5zaXplKTsKKwlpZiAoIShjYWNoZV9tYXNrICYgU1RBVFhfU0laRSkpIHsKKwkJ
aWYgKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkgJiYgYXR0ci0+c2l6ZSA+IG9sZHNpemUpIHsK
KwkJCXN0cnVjdCBmb2xpbyAqZm9saW87CisJCQlwZ29mZl90IGluZGV4ID0gb2xkc2l6ZSA+
PiBQQUdFX1NISUZUOworCisJCQlzcGluX3VubG9jaygmZmktPmxvY2spOworCQkJZm9saW8g
PSBfX2ZpbGVtYXBfZ2V0X2ZvbGlvKGlub2RlLT5pX21hcHBpbmcsIGluZGV4LAorCQkJCQkJ
ICAgIEZHUF9MT0NLIHwgRkdQX0NSRUFULAorCQkJCQkJICAgIG1hcHBpbmdfZ2ZwX21hc2so
aW5vZGUtPmlfbWFwcGluZykpOworCQkJaWYgKCFJU19FUlIoZm9saW8pKSB7CisJCQkJc3Bp
bl9sb2NrKCZmaS0+bG9jayk7CisJCQkJaWYgKCF0ZXN0X2JpdChGVVNFX0lfU0laRV9VTlNU
QUJMRSwgJmZpLT5zdGF0ZSkpIHsKKwkJCQkJZm9saW9fY2xlYXJfdXB0b2RhdGUoZm9saW8p
OworCQkJCQlpX3NpemVfd3JpdGUoaW5vZGUsIGF0dHItPnNpemUpOworCQkJCX0KKwkJCQlz
cGluX3VubG9jaygmZmktPmxvY2spOworCisJCQkJZm9saW9fdW5sb2NrKGZvbGlvKTsKKwkJ
CQlmb2xpb19wdXQoZm9saW8pOworCQkJCWdvdG8gc2l6ZV91cGRhdGVkOworCQkJfQorCQkJ
c3Bpbl9sb2NrKCZmaS0+bG9jayk7CisJCQkvKgorCQkJICogRm9saW8gYWxsb2MgZmFpbGVk
IChFTk9NRU0pLiBSZWNoZWNrIGluIGNhc2UgYQorCQkJICogd3JpdGUvdHJ1bmNhdGUgc3Rh
cnRlZCB3aGlsZSB3ZSBkcm9wcGVkIHRoZSBsb2NrLgorCQkJICovCisJCQlpZiAoIXRlc3Rf
Yml0KEZVU0VfSV9TSVpFX1VOU1RBQkxFLCAmZmktPnN0YXRlKSkKKwkJCQlpX3NpemVfd3Jp
dGUoaW5vZGUsIGF0dHItPnNpemUpOworCQl9IGVsc2UgeworCQkJaV9zaXplX3dyaXRlKGlu
b2RlLCBhdHRyLT5zaXplKTsKKwkJfQorCX0KIAlzcGluX3VubG9jaygmZmktPmxvY2spOwog
CitzaXplX3VwZGF0ZWQ6CisKIAlpZiAoIWNhY2hlX21hc2sgJiYgU19JU1JFRyhpbm9kZS0+
aV9tb2RlKSkgewogCQlib29sIGludmFsID0gZmFsc2U7CiAKLS0gCjIuNDcuMAoK

--------------PBWAN3Bbi1100Ta0o8JUsV1J--
